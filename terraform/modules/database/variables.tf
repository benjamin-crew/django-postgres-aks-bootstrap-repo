variable "rg_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "db_server_name" {
  type = string
}

variable "db_login" {
  type = string
}

variable "db_pass" {
  type = string
  sensitive = true
}

variable "subnet_name" {
  type = string
}

variable "address_prefixes" {
  type = list(string)
}

variable "private_dns_zone_name" {
  type = string
}

variable "dns_link_name" {
  type = string
}

variable "postgres_version" {
  type = string
}

variable "postgres_server_zone" {
  type = string
}

variable "postgres_storage" {
  type = number
}

variable "postgres_sku" {
  type = string
}

variable "db_name" {
  type = string
}