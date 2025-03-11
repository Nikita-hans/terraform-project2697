output "linux_availability_set_name" {
  value       = azurerm_availability_set.linux_avs.name
  description = "The name of the Linux availability set"
}

output "vm_hostname" {
  value       = values(azurerm_linux_virtual_machine.vmlinux)[*].name
  description = "The hostname of the VM"
}

output "vm_fqdn" {
  value       = values(azurerm_public_ip.linux_pip)[*].fqdn
  description = "The FQDN of the VM"
}

output "private_ip_address" {
  value       = values(azurerm_network_interface.linux_nic)[*].private_ip_address
  description = "The private IP address of the VM"
}

output "public_ip_address" {
  value       = values(azurerm_public_ip.linux_pip)[*].ip_address
  description = "The public IP address of the VM"
}

output "vm_ids" {
  description = "The ID's of the Linux virtual machine"
  value       = values(azurerm_linux_virtual_machine.vmlinux)[*].id
}

output "vm_nic_ids" {
  description = "The NIC ID's of the Linux virtual machine"
  value       = values(azurerm_network_interface.linux_nic)[*].id
}

