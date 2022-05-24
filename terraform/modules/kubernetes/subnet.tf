resource "azurerm_subnet" "aks-default" {
  name                 = var.aks_default_subnet
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
  address_prefixes     = var.aks_default_address_prefixes
}