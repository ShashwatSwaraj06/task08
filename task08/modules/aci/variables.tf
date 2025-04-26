variable "name" {
  description = "Name of the Azure Container Group (ACI)"
  type        = string
}

variable "location" {
  description = "Azure region for the ACI"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group for ACI"
  type        = string
}

variable "dns_name_label" {
  description = "DNS label for accessing the container group publicly"
  type        = string
}

variable "container_name" {
  description = "Name of the container inside ACI"
  type        = string
}

variable "image" {
  description = "Docker Image to deploy in the container group"
  type        = string
}

variable "cpu" {
  description = "CPU cores for container"
  type        = number
}

variable "memory" {
  description = "Memory (in GB) for container"
  type        = number
}

variable "tags" {
  description = "Tags for ACI resource"
  type        = map(string)
}

variable "redis_hostname" {
  description = "Redis hostname for secure environment variable"
  type        = string
  sensitive   = true
}

variable "redis_primary_key" {
  description = "Redis primary key for secure environment variable"
  type        = string
  sensitive   = true
}
