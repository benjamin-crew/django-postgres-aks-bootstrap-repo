# Resource Group
variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_tags" {
  type = map(string)
}

# Storage Account
variable "tf_storage_account_name" {
  type = string
}

variable "tf_sa_tags" {
  type = map(string)
}

# Virtual Network
variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}