#!/bin/bash

if [ -f .env ]
then
  export $(cat .env | xargs)
fi

SUPERUSER_EMAIL=${DJANGO_SUPERUSER_EMAIL}
cd /app/

/opt/.venv/bin/python manage.py migrate --noinput
/opt/.venv/bin/python manage.py createsuperuser --email $SUPERUSER_EMAIL --noinput || true
