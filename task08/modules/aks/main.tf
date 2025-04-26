resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  tags                = var.tags

  default_node_pool {
    name         = var.default_node_pool_name
    node_count   = var.default_node_pool_node_count
    vm_size      = var.default_node_pool_vm_size
    os_disk_type = var.default_node_pool_os_disk_type
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  storage_profile {
    blob_driver_enabled         = false
    disk_driver_enabled         = true
    file_driver_enabled         = true
    snapshot_controller_enabled = true
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}

resource "azurerm_key_vault_access_policy" "aks_policy" {
  key_vault_id = var.keyvault_id
  tenant_id    = azurerm_kubernetes_cluster.this.identity[0].tenant_id
  object_id    = azurerm_kubernetes_cluster.this.identity[0].principal_id

  secret_permissions = [
    "Get",
  ]
}
