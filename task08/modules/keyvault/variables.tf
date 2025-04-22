variable "name" {
  type        = string
  description = "Name of the Key Vault"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group where Key Vault will be deployed"
}

variable "location" {
  type        = string
  description = "Azure region for the deployment"
}

variable "sku" {
  type        = string
  description = "SKU name for Key Vault (standard or premium)"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Key Vault"
}