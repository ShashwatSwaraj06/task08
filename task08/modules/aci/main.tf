resource "azurerm_container_group" "aci" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  ip_address_type     = "Public"
  os_type             = "Linux"
  dns_name_label      = var.name
  restart_policy      = "Always"
  tags                = var.tags

  container {
    name   = var.name
    image  = "${var.acr_login_server}/${var.image_name}"
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }

    environment_variables = {
      "CREATOR"        = "ACI"
      "REDIS_PORT"     = "6380"
      "REDIS_SSL_MODE" = "True"
    }

    secure_environment_variables = {
      "REDIS_URL" = var.redis_hostname
      "REDIS_PWD" = var.redis_primary_key
    }
  }
}