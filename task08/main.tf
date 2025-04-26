provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = module.aks.kube_config[0].host
  client_certificate     = base64decode(module.aks.kube_config[0].client_certificate)
  client_key             = base64decode(module.aks.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_config[0].cluster_ca_certificate)
}

provider "kubectl" {
  host                   = module.aks.kube_config[0].host
  client_certificate     = base64decode(module.aks.kube_config[0].client_certificate)
  client_key             = base64decode(module.aks.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_config[0].cluster_ca_certificate)
  load_config_file       = false
}

resource "azurerm_resource_group" "this" {
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}

module "keyvault" {
  source              = "./modules/keyvault"
  name                = local.keyvault_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = "standard"
  tags                = local.tags
}

module "redis" {
  source                        = "./modules/redis"
  name                          = local.redis_name
  location                      = var.location
  resource_group_name           = azurerm_resource_group.this.name
  capacity                      = 2
  family                        = "C"
  sku_name                      = "Basic"
  tags                          = local.tags
  keyvault_id                   = module.keyvault.keyvault_id
  redis_hostname_secret_name    = "redis-hostname"
  redis_primary_key_secret_name = "redis-primary-key"
}

module "acr" {
  source      = "./modules/acr"
  name_prefix = var.name_prefix
  location    = var.location

  # Add the missing arguments
  sku          = "Basic"                                         # Define the SKU for your ACR (e.g., Basic, Standard, Premium)
  git_repo_url = "https://github.com/your-repo/your-project.git" # Replace with your GitHub repository URL
  image_name   = local.image_name                                # This should be set to the image name defined in locals.tf
}


module "aks" {
  source      = "./modules/aks"
  name_prefix = var.name_prefix
  location    = var.location

  # Required arguments for AKS
  name        = local.aks_name     # This will use the name defined in locals.tf
  tags        = local.tags         # This will use the tags defined in locals.tf
  acr_id      = module.acr.id      # Assuming the ACR module outputs the ID of the registry
  keyvault_id = module.keyvault.id # Assuming the KeyVault module outputs the ID of the Key Vault

  # Remove unsupported arguments (optional)
  # kubernetes_version = var.kubernetes_version   # Remove this line
  # enable_rbac        = true                      # Remove this line
}



module "aci" {
  source = "./modules/aci"

  name                = "${local.name_prefix}-aci"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  container_name    = local.container_name
  dns_name_label    = "${local.name_prefix}-aci"
  image             = "${module.acr.login_server}/${local.image_name}:latest"
  cpu               = 1
  memory            = 1.5
  redis_hostname    = module.redis.redis_hostname
  redis_primary_key = module.redis.redis_primary_key
}


resource "kubectl_manifest" "redis_secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    keyvault_name = module.keyvault.keyvault_uri
    tenant_id     = data.azurerm_client_config.current.tenant_id
  })
  depends_on = [module.aks]
}

resource "kubectl_manifest" "app_deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    image_name            = "${module.acr.login_server}/${local.image_name}:latest"
    redis_hostname_secret = "redis-hostname"
    redis_password_secret = "redis-primary-key"
  })
  depends_on = [kubectl_manifest.redis_secret_provider]
}

resource "kubectl_manifest" "app_service" {
  yaml_body  = file("${path.module}/k8s-manifests/service.yaml")
  depends_on = [kubectl_manifest.app_deployment]
}

data "kubernetes_service" "app_service" {
  metadata {
    name      = "app-service"
    namespace = "default"
  }
  depends_on = [kubectl_manifest.app_service]
}

data "azurerm_client_config" "current" {}
