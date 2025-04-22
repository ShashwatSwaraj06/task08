variable "name" {
  type        = string
  description = "Name of the Azure Container Instance"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group where ACI will be deployed"
}

variable "location" {
  type        = string
  description = "Azure region for the deployment"
}

variable "acr_login_server" {
  type        = string
  description = "ACR login server URL for pulling the container image"
}

variable "image_name" {
  type        = string
  description = "Name of the container image to deploy"
}

variable "redis_hostname" {
  type        = string
  description = "Redis hostname for the application"
}

variable "redis_primary_key" {
  type        = string
  sensitive   = true
  description = "Primary access key for Redis"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the container instance"
}