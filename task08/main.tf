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
  source              = "./modules/acr"
  name                = local.acr_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.tags
  git_pat             = var.git_pat
}

module "aks" {
  source = "./modules/aks"

  # Required arguments
  default_node_pool_node_count   = var.aks_node_pool_node_count   # Number of nodes in the default node pool
  default_node_pool_vm_size      = var.aks_node_pool_vm_size      # VM size for nodes in the default node pool
  default_node_pool_os_disk_type = var.aks_node_pool_os_disk_type # OS disk type for nodes in the default node pool
  default_node_pool_name         = var.aks_node_pool_name         # Name of the default node pool
  dns_prefix                     = var.aks_dns_prefix             # DNS prefix for the AKS cluster

  # Other arguments that you might have in your AKS module
  resource_group_name = module.rg.rg_name
  location            = var.location
  kubernetes_version  = var.kubernetes_version
  enable_rbac         = true
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
