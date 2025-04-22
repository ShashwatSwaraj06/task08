resource "azurerm_redis_cache" "redis" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku_name
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  tags                = var.tags
}