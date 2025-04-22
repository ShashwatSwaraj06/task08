output "aci_fqdn" {
  description = "Fully qualified domain name of the Azure Container Instance"
  value       = module.aci.fqdn
}

output "aks_lb_ip" {
  description = "Load Balancer IP address of the application in AKS"
  value       = module.aks.load_balancer_ip
}