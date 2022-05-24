resource "azurerm_postgresql_flexible_server" "postgres_server" {
  name                   = var.db_server_name
  resource_group_name    = data.azurerm_resource_group.rg.name
  location               = data.azurerm_resource_group.rg.location
  version                = var.postgres_version
  delegated_subnet_id    = azurerm_subnet.postgres_sb.id
  private_dns_zone_id    = azurerm_private_dns_zone.private_dns_zone.id
  administrator_login    = var.db_login
  administrator_password = var.db_pass
  zone                   = var.postgres_server_zone

  storage_mb = var.postgres_storage

  sku_name   = var.postgres_sku
  depends_on = [azurerm_private_dns_zone_virtual_network_link.dns_link]

}

resource "azurerm_postgresql_flexible_server_database" "postgres_db" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.postgres_server.id
  collation = "en_US.utf8"
  charset   = "utf8"
}