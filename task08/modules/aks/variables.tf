variable "name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region for AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group for AKS"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for AKS API server"
  type        = string
}

variable "default_node_pool_name" {
  description = "Default Node Pool Name"
  type        = string
}

variable "default_node_pool_node_count" {
  description = "Number of nodes in default pool"
  type        = number
}

variable "default_node_pool_vm_size" {
  description = "VM Size for nodes"
  type        = string
}

variable "default_node_pool_os_disk_type" {
  description = "OS disk type for nodes (Managed or Ephemeral)"
  type        = string
}

variable "tags" {
  description = "Tags for AKS resource"
  type        = map(string)
}

variable "acr_id" {
  description = "ACR Resource ID for AcrPull permission"
  type        = string
}

variable "keyvault_id" {
  description = "Key Vault ID for granting access to secrets"
  type        = string
}
