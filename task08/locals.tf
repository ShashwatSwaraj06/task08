# locals.tf
locals {
  common_tags = {
    Creator = var.creator_tag
  }

  # Add this line
  name_prefix = var.name_prefix

  # Rest of your existing locals
  rg_name       = "${var.name_prefix}-rg"
  aci_name      = "${var.name_prefix}-ci"
  acr_name      = replace("${var.name_prefix}cr", "-", "")
  aks_name      = "${var.name_prefix}-aks"
  keyvault_name = "${var.name_prefix}-kv"
  redis_name    = "${var.name_prefix}-redis"
  docker_image  = "${var.name_prefix}-app"
}