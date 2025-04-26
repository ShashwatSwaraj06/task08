resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true
  tags                = var.tags
}

resource "azurerm_container_registry_task" "this" {
  name                  = "${var.name}-task"
  container_registry_id = azurerm_container_registry.this.id
  location              = var.location
  platform {
    os = "Linux"
  }
  agent_pool_name = "Default"
  docker_step {
    dockerfile_path      = "Dockerfile"
    context_access_token = var.git_pat
    context_path         = var.git_repo_url
    image_names          = ["${var.image_name}:latest"]
    is_push_enabled      = true
  }
}

resource "azurerm_container_registry_task_schedule" "this" {
  name                       = "${var.name}-task-schedule"
  container_registry_task_id = azurerm_container_registry_task.this.id
  schedule                   = "0 */1 * * *" # every 1 hour
  enabled                    = true
}
