variable "name" {
  description = "Name of the Redis Cache instance"
  type        = string
}

variable "location" {
  description = "Azure region for Redis Cache"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group for Redis Cache"
  type        = string
}

variable "capacity" {
  description = "Capacity of the Redis instance (0-6)"
  type        = number
}

variable "family" {
  description = "Family of the Redis SKU (C = Basic/Standard, P = Premium)"
  type        = string
}

variable "sku_name" {
  description = "SKU name of the Redis Cache (Basic/Standard/Premium)"
  type        = string
}

variable "tags" {
  description = "Tags for Redis Cache"
  type        = map(string)
}

variable "keyvault_id" {
  description = "Key Vault ID to store Redis secrets"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Key Vault secret name for Redis hostname"
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "Key Vault secret name for Redis primary access key"
  type        = string
}
