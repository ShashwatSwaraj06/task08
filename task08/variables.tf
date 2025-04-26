variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "git_pat" {
  description = "GitHub Personal Access Token for ACR tasks"
  type        = string
  sensitive   = true
}

variable "name_prefix" {
  description = "Name prefix to be used for naming all resources"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
}

variable "dns_name_label" {
  description = "DNS name label for ACI"
  type        = string
}

variable "image_name" {
  description = "Name of the image to be used in ACI"
  type        = string
}

variable "cpu" {
  description = "Number of CPUs for the container"
  type        = number
}

variable "memory" {
  description = "Amount of memory for the container (in GB)"
  type        = number
}

# Node pool settings
variable "aks_node_pool_node_count" {
  description = "The number of nodes in the default node pool"
  type        = number
  default     = 3
}

variable "aks_node_pool_vm_size" {
  description = "The size of the VM for the default node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "aks_node_pool_os_disk_type" {
  description = "The OS disk type for the default node pool"
  type        = string
  default     = "Managed"
}

variable "aks_node_pool_name" {
  description = "The name of the default node pool"
  type        = string
  default     = "default"
}

variable "aks_dns_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
  default     = "aks-cluster"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg1" # Adjust as needed
}

