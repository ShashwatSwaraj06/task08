variable "name_prefix" {
  type    = string
  default = "cmtr-57d8b090-mod8"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "acr_sku" {
  type    = string
  default = "Basic"
}

variable "git_pat" {
  type      = string
  sensitive = true
}

variable "creator_tag" {
  type    = string
  default = "shashwat_swaraj@epam.com"
}