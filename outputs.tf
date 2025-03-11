output "resource_group_name" {
  value = module.rgroup-2697.resource_group_name
}

output "vnet_name" {
  value = module.network-2697.vnet_name
}

output "subnet_name" {
  value = module.network-2697.subnet_name
}

output "log_analytics_workspace_name" {
  value = module.common-2697.log_analytics_workspace_name
}

output "recovery_services_vault_name" {
  value = module.common-2697.recovery_services_vault_name
}

output "storage_account_name" {
  value = module.common-2697.storage_account_name
}

output "linux_availability_set_name" {
  value       = module.vmlinux-n01702697.linux_availability_set_name
}

output "linux_vm_hostname" {
  value       = module.vmlinux-n01702697.vm_hostname
}

output "linux_vm_fqdn" {
  value       = module.vmlinux-n01702697.vm_fqdn
}

output "linux_vm_private_ip_address" {
  value       = module.vmlinux-n01702697.private_ip_address
}

output "linux_vm_public_ip_address" {
  value       = module.vmlinux-n01702697.public_ip_address
}

output "availability_set_name" {
  value       = module.vmwindows-n01702697.availability_set_name
}

output "windows_vm_hostnames" {
  value       = module.vmwindows-n01702697.vm_hostnames
}

output "windows_vm_fqdns" {
  value       = module.vmwindows-n01702697.vm_fqdns
}

output "windows_vm_private_ips" {
  value       = module.vmwindows-n01702697.vm_private_ips
}

output "windows_vm_public_ips" {
  value       = module.vmwindows-n01702697.vm_public_ips
}


output "load_balancer_name" {
  value       = module.loadbalancer-n01702697.load_balancer_name
}

output "db_instance_name" {
  value = module.database-2697.db_instance_name
}

output "db_server_name" {
  value       = module.database-2697.db_server_name
}