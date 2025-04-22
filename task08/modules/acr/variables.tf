variable "name" {
  type        = string
  description = "Name of the Azure Container Registry"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group where ACR will be created"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be deployed"
}

variable "sku" {
  type        = string
  description = "SKU tier for the container registry (Basic, Standard, Premium)"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags to apply"
}

variable "git_pat" {
  type        = string
  sensitive   = true
  description = "GitHub Personal Access Token for ACR build task authentication"
}

variable "image_name" {
  type        = string
  description = "Name of the Docker image to build"
  default     = "app"
}