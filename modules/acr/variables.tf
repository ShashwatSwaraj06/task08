variable "name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sku" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "git_pat" {
  type      = string
  sensitive = true
}

variable "image_name" {
  type    = string
  default = "app"
}