# django-postgres-aks-bootstrap-repo
This is a bootstrap repo for a Django project with a managed Postgres backend, hosted in Azure Kubernetes Service.
### Django
- Fork the repo
- Create and activate your venv
```bash
# .venv is referenced throughout the project, so make sure to name it .venv
python3 -m venv .venv
source .venv/bin/activate
```
- cd into the 'web' folder
- Make any changes to the requirements.txt file that you may want, then install it. Check the LTS here https://www.djangoproject.com/download/ and update requirements.txt if you don't wish to use 3.2:
```bash
pip install -r requirements.txt
```
- Create your django project
```bash
django-admin startproject <projectname> .
```
- Create a .env.prod file that we can create a k8s secret from later on. Please note that there are a few values here that align with terraform variables, so make sure to take care to set them the same as you set them in terraform. Also be sure to change the default passwords and secret_keys etc. Theses are just a guide:
```bash
DEBUG=0
DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_PASSWORD=Jgkf&bn^Y^%5x£z
DJANGO_SUPERUSER_EMAIL=example@gmail.com
DJANGO_SECRET_KEY=9ev7=zy6ru&2ju$u^!!_vrp9_p)i!w(=u_01^y)^$#f=lvjq)3

POSTGRES_DB=exampleprojectdb
POSTGRES_PASSWORD=Nshu4sdzZ46y32g*v6fxd
POSTGRES_USER=psqladmin
POSTGRES_HOST=exampleprojectdb.postgres.database.azure.com
POSTGRES_PORT=5432
```
- Make the following changes to wsgi.py. Check the example folder for an example:
```py
import pathlib
import dotenv

CURRENT_DIR = pathlib.Path(__file__).resolve().parent
BASE_DIR = CURRENT_DIR.parent
ENV_FILE_PATH = BASE_DIR / ".env"
dotenv.read_dotenv(str(ENV_FILE_PATH))
```

- Make the following changes to manage.py. Check the example folder for an example:
```py
import dotenv

if __name__ == '__main__':
    dotenv.read_dotenv()
    main()
```
- Update the entrypoint.sh file to include your project name:
```
#!/bin/bash
APP_PORT=${PORT:-8000}

cd /app/
/opt/.venv/bin/gunicorn --worker-tmp-dir /dev/shm example_project.wsgi:application --bind "0.0.0.0:${APP_PORT}"
```
- Now we need to update the settings.py file to read the env vars. There's a few bits to add here so again, check out the example folder for a practical example:
```py
import os

SECRET_KEY = os.environ.get("DJANGO_SECRET_KEY")
DEBUG = str(os.environ.get("DEBUG")) == "1"
ALLOWED_HOSTS = ["*"]

DB_USERNAME = os.environ.get("POSTGRES_USER")
DB_PASSWORD = os.environ.get("POSTGRES_PASSWORD")
DB_DATABASE = os.environ.get("POSTGRES_DB")
DB_HOST = os.environ.get("POSTGRES_HOST")
DB_PORT = os.environ.get("POSTGRES_PORT")

DB_IS_AVAILABLE = all([
    DB_USERNAME,
    DB_PASSWORD,
    DB_DATABASE,
    DB_HOST,
    DB_PORT
])
DB_IGNORE_SSL=os.environ.get("DB_IGNORE_SSL") == "true"

# Production database is not avaiable if env vars are not set
# If production database is not avaiable, it will default to mysql
if DB_IS_AVAILABLE:
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql',
            'NAME': DB_DATABASE,
            'USER': DB_USERNAME,
            'PASSWORD': DB_PASSWORD,
            'HOST': DB_HOST,
            'PORT': DB_PORT
        }
    }

    if not DB_IGNORE_SSL:
        DATABASES["default"]["OPTIONS"] = {
            "sslmode": "require"
        }
```
- Make sure the version of python used in the Dockerfile is the same one you used for your Django project.

### Terraform

- Go through and modify each variables.tf file within /terraform/deployments to suit your needs. The db_pass from the database module should probably be moved into a secret store.
- Build the 'environment' module locally, using your own account. Move the backend.tf file out of the directory and then run the following commands:
```bash
az account set --subscription="SUBSCRIPTION-ID"
terraform init
terraform apply
```
- Move the backend.tf file back into the directory then run the terraform init again, typing 'yes' to migrate state.
- Now go through the kubernetes and database deployments and update the backend.tf files to suit your environment.
- Create an SPN for the project, give it owner permissions to the resource group, and add it to Github secrets. You can be more granular if you like, but for the sake of this example i'm just giving it Owner. Contributer doesn't cut it.
    - Store the output of the below az cli command as the value of Github Actions secret variable, for example 'AZURE_CREDENTIALS'
        - az ad sp create-for-rbac --name "myApp" --role owner \
            --scopes /subscriptions/{subscriptionid}]/resourceGroups/{resource-group} \
            --sdk-auth

            The command should output a JSON object similar to this:

            {
                "clientId": "<GUID>",
                "clientSecret": "<STRING>",
                "subscriptionId": "<GUID>",
                "tenantId": "<GUID>",
                "resourceManagerEndpointUrl": "<URL>"
                (...)
            }
- Create the following Github Secrets from the json output:
        - ARM_CLIENT_ID
        - ARM_CLIENT_SECRET
        - ARM_SUBSCRIPTION_ID
        - ARM_TENANT_ID
- Create the following Github Secrets using your .env.prod file as reference:
        - DJANGO_SECRET_KEY
        - DJANGO_SUPERUSER_EMAIL
        - DJANGO_SUPERUSER_PASSWORD
        - DJANGO_SUPERUSER_USERNAME
        - POSTGRES_DB
        - POSTGRES_HOST
        - POSTGRES_PASSWORD
        - POSTGRES_PORT
        - POSTGRES_USER

### Kubernetes

- Open the build-k8s.yaml file and change the env variables to suit your environment.
- Go into the .github/workflows/build-k8s.yaml file and update the env var's to suit your environment.
- Go into the k8s/manifests/deployment.yaml file and update to suit your environment, or copy your own file over and replace it.

### Deployment

- Push your changes to Github and the terraform.yaml workflow should kick off.
- Once terraform has finished doing it's thing, you need to create two more Github Secrets. Go to your container registry in Azure > Settings > Access Keys:
    - From the 'Username' field, create the REGISTRY_USERNAME Github Secret.
    - From the 'password' field, create the REGISTRY_PASSWORD Github Secret.
- Manually run the 'Build Docker Container & Push to ACR' workflow.
