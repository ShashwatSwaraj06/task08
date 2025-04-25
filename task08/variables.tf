variable "location" {
  type        = string
  description = "location of resource group"
  default     = "East US"
}

variable "container_registry_name" {
  description = "value"
  type        = string
}


variable "container_group_name" {
  description = "value"
  type        = string
}

variable "name_pattern" {
  description = "value"
  type        = string
  default     = "cmtr-64aed6d7-mod8"
}

variable "key_vault_name" {
  description = "value"
  type        = string
}