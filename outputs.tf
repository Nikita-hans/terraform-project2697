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

