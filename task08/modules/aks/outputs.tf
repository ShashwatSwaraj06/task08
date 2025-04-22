output "kube_config" {
  description = "Kubernetes configuration for connecting to the cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config
  sensitive   = true
}

output "host" {
  description = "Kubernetes API server host"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
}

output "client_certificate" {
  description = "Client certificate for authenticating to the cluster"
  value       = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate)
  sensitive   = true
}

output "client_key" {
  description = "Client key for authenticating to the cluster"
  value       = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_key)
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Cluster CA certificate"
  value       = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
  sensitive   = true
}