resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
}

resource "azurerm_container_registry_task" "example" {
  name                  = var.registrytask_name
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os = var.os_type
  }

  # Use Git context with PAT
  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "https://github.com/ShashwatSwaraj06/task08.git"
    context_access_token = var.git_pat
    image_names          = ["${var.name}/${var.image_name}:latest"]
  }

  tags = var.tags
}

resource "azurerm_container_registry_task_schedule_run_now" "this" {
  container_registry_task_id = azurerm_container_registry_task.example.id
}