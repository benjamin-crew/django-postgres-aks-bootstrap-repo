terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.1.0"
    }
  }

  required_version = ">= 1.1.8"
}

module "kubernetes" {
  source = "../../modules/kubernetes"

  rg_name = var.rg_name
  aks_name = var.aks_name
  aks_node_pool_name = var.aks_node_pool_name
  aks_vm_size = var.aks_vm_size
  aks_dns_prefix = var.aks_dns_prefix
  acr_name = var.acr_name
  vnet_name               = var.vnet_name
  aks_default_subnet = var.aks_default_subnet
  aks_default_address_prefixes = var.aks_default_address_prefixes
  aks_node_count = var.aks_node_count
  aks_max_count = var.aks_max_count
  aks_min_count = var.aks_min_count  
}