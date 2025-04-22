output "host" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].host
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "load_balancer_ip" {
  value = kubernetes_service.app.status[0].load_balancer[0].ingress[0].ip
}