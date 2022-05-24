variable "rg_name" {
  type    = string
  default = "bc-tst-example-rg01"
}

variable "vnet_name" {
  type = string
  default = "bc-tst-example-vnet01"
}

variable "db_server_name" {
  type = string
  default = "example-postgres-server"
}

variable "db_login" {
  type = string
  default = "psqladmin"
}

variable "db_pass" {
  type = string
  sensitive = true
  default = "Nshu4sdzZ46y32g*v6fxd"
}

variable "subnet_name" {
  type = string
  default = "postgres-sb"
}

variable "address_prefixes" {
  type = list(string)
  default = ["172.18.16.0/24"]
}

variable "private_dns_zone_name" {
  type = string
  default = "example-aks.postgres.database.azure.com"
}

variable "dns_link_name" {
  type = string
  default = "example-aks.com"
}

variable "postgres_version" {
  type = string
  default = "12"
}

variable "postgres_server_zone" {
  type = string
  default = "1"
}

variable "postgres_storage" {
  type = number
  default = 32768
}

variable "postgres_sku" {
  type = string
  default = "B_Standard_B1ms"
}

variable "db_name" {
  type = string
  default = "exampleprojectdb"
}
