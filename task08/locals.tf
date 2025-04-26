locals {
  # Prefix used for resource names
  name_pattern = var.name_prefix

  # Resource names based on name pattern
  rg_name       = "${local.name_pattern}-rg"
  redis_name    = "${local.name_pattern}-redis"
  keyvault_name = "${local.name_pattern}-kv"
  acr_name      = replace(local.name_pattern, "-", "") # ACR name should not have hyphens
  aks_name      = "${local.name_pattern}-aks"
  aci_name      = "${local.name_pattern}-ci"

  # Container name for ACI (Azure Container Instance)
  container_name = "${local.name_pattern}-aci-container" # New container name based on name pattern

  # Image name for ACR (Azure Container Registry) -- define the image name using ACR path
  image_name = "${local.name_pattern}-app"

  # Tags for all resources
  tags = {
    Creator = "shashwat_swaraj@epam.com"
  }
}
