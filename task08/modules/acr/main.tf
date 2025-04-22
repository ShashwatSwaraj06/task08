resource "azurerm_container_registry" "acr" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true
  tags                = var.tags
}

resource "azurerm_container_registry_task" "build_task" {
  name                  = "${var.name}-build-task"
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os = "Linux"
  }

  # Use local context instead of Git repo
  source_location = "."

  docker_step {
    dockerfile_path = "Dockerfile"
    image_names     = ["${var.name}/${var.image_name}:latest"]
    context_path    = "application" # Path to your Docker build context
  }

  tags = var.tags
}

# resource "azurerm_container_registry_task_schedule_run_now" "trigger" {
#   container_registry_task_id = azurerm_container_registry_task.build_task.id
#   depends_on                 = [azurerm_container_registry_task.build_task]
# }