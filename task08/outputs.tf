output "aci_fqdn" {
  description = "The FQDN of the Azure Container Instance"
  value       = module.aci.fqdn
}

output "aks_lb_ip" {
  description = "The external LoadBalancer IP of the AKS application"
  value       = data.kubernetes_service.app_service.status[0].load_balancer[0].ingress[0].ip
}
