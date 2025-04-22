variable "name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "acr_login_server" {
  type = string
}

variable "image_name" {
  type = string
}

variable "redis_hostname" {
  type = string
}

variable "redis_primary_key" {
  type      = string
  sensitive = true
}

variable "tags" {
  type = map(string)
}