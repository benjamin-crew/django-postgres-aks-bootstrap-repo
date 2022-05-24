terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.1.0"
    }
  }

  required_version = ">= 1.1.8"
}

module "env" {
  source = "../../modules/environment"

  rg_name                 = var.rg_name
  location                = var.location
  rg_tags                 = var.rg_tags
  tf_storage_account_name = var.tf_storage_account_name
  tf_sa_tags              = var.tf_sa_tags
  vnet_name               = var.vnet_name
  address_space           = var.address_space
}
