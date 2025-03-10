# Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = "n01702697-log-analytics"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}

# Create Recovery Services Vault
resource "azurerm_recovery_services_vault" "vault" {
  name                = "n01702697-recovery-vault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  tags = var.tags
}

# Create Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = "n01702697storacc"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

