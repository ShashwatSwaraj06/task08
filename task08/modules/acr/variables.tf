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
  description = "Azure region for the deployment"
}

variable "sku" {
  type        = string
  description = "SKU tier for the container registry (Basic, Standard, Premium)"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the container registry"
}

variable "git_pat" {
  type        = string
  sensitive   = true
  description = "GitHub Personal Access Token for ACR build authentication"
}

variable "image_name" {
  type        = string
  description = "Name of the Docker image to build"
  default     = "app"
}