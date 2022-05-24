resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  dns_prefix          = var.aks_dns_prefix

  default_node_pool {
    name       = var.aks_node_pool_name
    node_count = var.aks_node_count
    enable_auto_scaling  = true
    max_count            = var.aks_max_count
    min_count            = var.aks_min_count
    vm_size    = var.aks_vm_size
    vnet_subnet_id        = azurerm_subnet.aks-default.id 
  }

  identity {
    type = "SystemAssigned"
  }
}
