variable "name_prefix" {
  type        = string
  default     = "cmtr-57d8b090-mod8"
  description = "Prefix for all resource names"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Azure region for resources"
}

variable "acr_sku" {
  type        = string
  default     = "Basic"
  description = "SKU for Azure Container Registry"
}

variable "git_pat" {
  type        = string
  sensitive   = true
  description = "GitHub Personal Access Token for ACR build"
}

variable "creator_tag" {
  type        = string
  default     = "shashwat_swaraj@epam.com"
  description = "Tag value for Creator"
}