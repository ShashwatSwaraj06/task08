terraform {
  required_version = ">= 1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0, < 4.0.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "2d0ddb92-adf2-4b04-aade-aed98d65269a"
  tenant_id       = "b41b72d0-4e9f-4c26-8a69-f949f367c91d"
}