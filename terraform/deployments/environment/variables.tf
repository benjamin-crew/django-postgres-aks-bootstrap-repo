# Resource Group
variable "rg_name" {
  type    = string
  default = "bc-tst-example-rg01"
}
variable "location" {
  type    = string
  default = "uksouth"
}

variable "rg_tags" {
  type = map(string)
  default = {
    owner = "Example person"
    usage = "Resource Group to store example_project website resources."
  }
}

# Storage Account
variable "tf_storage_account_name" {
  type    = string
  default = "bctstexampletfsa01"
}

variable "tf_sa_tags" {
  type = map(string)
  default = {
    owner = "Example person"
    usage = "Storage account to store example_project website resources."
  }
}

# Virtual Network
variable "vnet_name" {
  type = string
  default = "bc-tst-example-vnet01"
}

variable "address_space" {
  type = list(string)
  default = ["172.18.0.0/16"]
}