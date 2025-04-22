# Create Resource Group
resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}

# Deploy Redis Cache
module "redis" {
  source     = "./modules/redis"
  name       = local.redis_name
  location   = var.location
  rg_name    = azurerm_resource_group.main.name
  sku_name   = "Basic"
  capacity   = 2
  family     = "C"
  tags       = local.common_tags
  depends_on = [azurerm_resource_group.main]
}

# Deploy Key Vault
module "keyvault" {
  source     = "./modules/keyvault"
  name       = local.keyvault_name
  location   = var.location
  rg_name    = azurerm_resource_group.main.name
  sku        = "standard"
  tags       = local.common_tags
  depends_on = [azurerm_resource_group.main]
}

# Store Redis secrets in Key Vault
resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = "redis-hostname"
  value        = module.redis.hostname
  key_vault_id = module.keyvault.id
  depends_on   = [module.keyvault, module.redis]
}

resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = "redis-primary-key"
  value        = module.redis.primary_key
  key_vault_id = module.keyvault.id
  depends_on   = [module.keyvault, module.redis]
}

# Deploy ACR
module "acr" {
  source     = "./modules/acr"
  name       = local.acr_name
  location   = var.location
  rg_name    = azurerm_resource_group.main.name
  sku        = var.acr_sku
  tags       = local.common_tags
  git_pat    = var.git_pat
  depends_on = [azurerm_resource_group.main]
}

# Deploy AKS
module "aks" {
  source       = "./modules/aks"
  name         = local.aks_name
  location     = var.location
  rg_name      = azurerm_resource_group.main.name
  node_count   = 1
  vm_size      = "Standard_D2ads_v5"
  os_disk_type = "Ephemeral"
  acr_id       = module.acr.id
  key_vault_id = module.keyvault.id
  tags         = local.common_tags
  depends_on   = [module.acr, module.keyvault]
}

# Deploy ACI
module "aci" {
  source            = "./modules/aci"
  name              = local.aci_name
  location          = var.location
  rg_name           = azurerm_resource_group.main.name
  acr_login_server  = module.acr.login_server
  image_name        = "${local.docker_image}:latest"
  redis_hostname    = azurerm_key_vault_secret.redis_hostname.value
  redis_primary_key = azurerm_key_vault_secret.redis_primary_key.value
  tags              = local.common_tags
  depends_on        = [module.acr, module.keyvault, module.redis]
}

# Configure kubectl provider
provider "kubectl" {
  host                   = module.aks.host
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  load_config_file       = false
}

# Deploy Kubernetes manifests
resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    key_vault_name = local.keyvault_name
  })
  depends_on = [module.aks]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    image_name     = "${module.acr.login_server}/${local.docker_image}:latest"
    redis_hostname = module.redis.hostname
    redis_port     = "6380"
  })
  depends_on = [kubectl_manifest.secret_provider, module.acr]
}

resource "kubectl_manifest" "service" {
  yaml_body  = file("${path.module}/k8s-manifests/service.yaml")
  depends_on = [kubectl_manifest.deployment]
}