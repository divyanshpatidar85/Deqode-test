output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.nomad.name
}

output "resource_group_location" {
  description = "Resource group location"
  value       = azurerm_resource_group.nomad.location
}

output "virtual_network_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
  description = "Subnet name"
  value       = azurerm_subnet.nomad_subnet.name
}

output "nomad_server_public_ips" {
  description = "Public IP addresses of the Nomad servers"
  value       = azurerm_public_ip.nomad_server_ips[*].ip_address
}

output "nomad_client_public_ips" {
  description = "Public IP addresses of the Nomad clients"
  value       = azurerm_public_ip.nomad_client_ips[*].ip_address
}

output "nomad_server_private_ips" {
  description = "Private IP addresses of the Nomad servers"
  value       = azurerm_network_interface.nomad_server_nics[*].private_ip_address
}

output "nomad_client_private_ips" {
  description = "Private IP addresses of the Nomad clients"
  value       = azurerm_network_interface.nomad_client_nics[*].private_ip_address
}

output "nomad_server_names" {
  description = "Names of the Nomad server VMs"
  value       = azurerm_linux_virtual_machine.nomad_servers[*].name
}

output "nomad_client_names" {
  description = "Names of the Nomad client VMs"
  value       = azurerm_linux_virtual_machine.nomad_clients[*].name
}

output "ssh_connection_server" {
  description = "SSH connection command for the first server"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.nomad_server_ips[0].ip_address}"
}

output "ssh_connection_client" {
  description = "SSH connection command for the first client"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.nomad_client_ips[0].ip_address}"
}

output "nomad_ui_url" {
  description = "Nomad UI URL (secured with ACL token)"
  value       = "http://${azurerm_public_ip.nomad_server_ips[0].ip_address}:4646"
}

output "nomad_bootstrap_token" {
  description = "Nomad bootstrap token for UI access"
  value       = random_string.nomad_bootstrap_token.result
  sensitive   = true
}

output "hello_world_app_url" {
  description = "Hello World application URL (deployed after cluster is ready)"
  value       = "http://${azurerm_public_ip.nomad_client_ips[0].ip_address}:8080"
}