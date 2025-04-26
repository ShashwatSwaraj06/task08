output "kube_config" {
  description = "Kube config block to connect to the cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "aks_id" {
  description = "AKS Resource ID"
  value       = azurerm_kubernetes_cluster.this.id
}

output "aks_host" {
  description = "AKS API Server Host URL"
  value       = azurerm_kubernetes_cluster.this.kube_config[0].host
}

output "aks_client_certificate" {
  description = "AKS Client Certificate"
  value       = azurerm_kubernetes_cluster.this.kube_config[0].client_certificate
  sensitive   = true
}
