# Azure region where resources will be created
location = "East US"

# GitHub Personal Access Token (sensitive, replace with actual token)
git_pat = "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"

# Name prefix to be used for naming all resources
name_prefix = "cmtr-57d8b090-mod8"

# ACI Variables (example)
dns_name_label = "cmtr-aci" # You can change this based on your needs

# Image and container setup
image_name = "cmtr-57d8b090-app" # Replace with your actual image name

# ACI container resources
cpu    = 2 # Specify the number of CPUs for the container
memory = 4 # Specify the amount of memory (in GB) for the container

# AKS Node Pool setup (customize if needed)
aks_node_pool_node_count   = 3
aks_node_pool_vm_size      = "Standard_DS2_v2"
aks_node_pool_os_disk_type = "Managed"
aks_node_pool_name         = "default"
aks_dns_prefix             = "aks-cluster" # Prefix used in DNS for AKS
acr_name                   = "myacrregistry"

# Tags to be applied to all resources
tags = {
  Creator     = "shashwat_swaraj@epam.com"
  Project     = "CMTR"
  Environment = "Production"
}
