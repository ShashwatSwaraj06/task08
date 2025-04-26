variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "git_pat" {
  description = "GitHub Personal Access Token for ACR tasks"
  type        = string
  sensitive   = true
}
