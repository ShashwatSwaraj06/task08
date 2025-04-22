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

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "https://github.com/your-repo/your-app#main"
    context_access_token = var.git_pat
    image_names          = ["${var.name}/${var.image_name}:latest"]
  }

  tags = var.tags
}

resource "azurerm_container_registry_task_schedule_run_now" "trigger" {
  container_registry_task_id = azurerm_container_registry_task.build_task.id
  depends_on                 = [azurerm_container_registry_task.build_task]
}