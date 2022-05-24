terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.1.0"
    }
  }

  required_version = ">= 1.1.8"
}

module "database" {
  source = "../../modules/database"

  rg_name                 = var.rg_name
  vnet_name               = var.vnet_name
  db_login                = var.db_login
  db_pass                 = var.db_pass
  subnet_name = var.subnet_name
  address_prefixes = var.address_prefixes
  private_dns_zone_name = var.private_dns_zone_name
  dns_link_name = var.dns_link_name
  postgres_version = var.postgres_version
  postgres_server_zone = var.postgres_server_zone
  postgres_storage = var.postgres_storage
  postgres_sku = var.postgres_sku
  db_name = var.db_name
  db_server_name = var.db_server_name

}