output "aci_fqdn" {
  value = module.aci.fqdn
}

output "aks_lb_ip" {
  value = module.aks.load_balancer_ip
}