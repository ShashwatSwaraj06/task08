variable "name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "capacity" {
  type = number
}

variable "family" {
  type = string
}

variable "tags" {
  type = map(string)
}