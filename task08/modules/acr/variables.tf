variable "name" {
  description = "Name of the ACR resource"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where ACR is deployed"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "sku" {
  description = "SKU for Azure Container Registry"
  type        = string
}

variable "tags" {
  description = "Tags to apply on ACR"
  type        = map(string)
}

variable "git_pat" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

variable "git_repo_url" {
  description = "GitHub Repository URL"
  type        = string
}

variable "image_name" {
  description = "Docker Image Name"
  type        = string
}
