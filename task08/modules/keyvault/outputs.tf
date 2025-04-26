output "keyvault_id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.this.id
}

output "keyvault_uri" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.this.vault_uri
}
