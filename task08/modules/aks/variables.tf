variable "name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group where AKS will be deployed"
}

variable "location" {
  type        = string
  description = "Azure region for the deployment"
}

variable "node_count" {
  type        = number
  description = "Number of nodes in the default node pool"
  default     = 1
}

variable "vm_size" {
  type        = string
  description = "Size of the VMs in the node pool"
  default     = "Standard_D2ads_v5"
}

variable "os_disk_type" {
  type        = string
  description = "OS disk type for nodes"
  default     = "Ephemeral"
}

variable "acr_id" {
  type        = string
  description = "ACR resource ID for cluster integration"
}

variable "key_vault_id" {
  type        = string
  description = "Key Vault resource ID for cluster integration"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the AKS cluster"
}