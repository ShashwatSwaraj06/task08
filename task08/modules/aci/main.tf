resource "azurerm_container_group" "container" {
  name                = var.container_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = var.restart_policy
  sku                 = "Standard"

  container {
    name   = var.container_group_name
    image  = var.image
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

    environment_variables = {
      CREATOR        = "ACI"
      REDIS_PORT     = "6380"
      REDIS_SSL_MODE = "True"
    }

    secure_environment_variables = {
      REDIS_URL = var.redis_hostname
      REDIS_PWD = var.redis_primary_key
    }

    ports {
      port     = var.port
      protocol = "TCP"
    }
  }

  dns_name_label = var.dns_name_label
  tags           = var.tags
}