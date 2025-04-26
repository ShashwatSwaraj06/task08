locals {
  name_pattern = "cmtr-57d8b090-mod8"

  rg_name       = "${local.name_pattern}-rg"
  redis_name    = "${local.name_pattern}-redis"
  keyvault_name = "${local.name_pattern}-kv"
  acr_name      = replace(local.name_pattern, "-", "") # No hyphens for ACR
  aks_name      = "${local.name_pattern}-aks"
  aci_name      = "${local.name_pattern}-ci"
  image_name    = "${local.name_pattern}-app"

  tags = {
    Creator = "shashwat_swaraj@epam.com"
  }
}
