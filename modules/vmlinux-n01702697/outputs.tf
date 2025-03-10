output "linux_availability_set_name" {
  value       = azurerm_availability_set.linux_avs.name
  description = "The name of the Linux availability set"
}

output "vm_hostname" {
  value       = azurerm_linux_virtual_machine.vmlinux[*].name
  description = "The hostname of the VM"
}

output "vm_fqdn" {
  value       = azurerm_public_ip.linux_pip[*].fqdn
  description = "The FQDN of the VM"
}

output "private_ip_address" {
  value       = azurerm_network_interface.linux_nic[*].ip_configuration[0].private_ip_address
  description = "The private IP address of the VM"
}

output "public_ip_address" {
  value       = azurerm_public_ip.linux_pip[*].ip_address
  description = "The public IP address of the VM"
}

