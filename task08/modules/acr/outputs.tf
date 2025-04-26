output "acr_login_server" {
  description = "ACR Login Server URL"
  value       = azurerm_container_registry.this.login_server
}

output "acr_id" {
  description = "ACR Resource ID"
  value       = azurerm_container_registry.this.id
}
