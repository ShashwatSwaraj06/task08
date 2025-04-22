variable "name" {
  type        = string
  description = "Name of the Redis Cache"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group where Redis will be deployed"
}

variable "location" {
  type        = string
  description = "Azure region for the deployment"
}

variable "sku_name" {
  type        = string
  description = "Redis SKU name (Basic, Standard, Premium)"
}

variable "capacity" {
  type        = number
  description = "Redis cache size (1-6 for Basic/Standard, 1-5 for Premium)"
}

variable "family" {
  type        = string
  description = "Redis SKU family (C for Basic/Standard, P for Premium)"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Redis Cache"
}