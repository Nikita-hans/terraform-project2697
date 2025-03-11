resource "azurerm_postgresql_server" "pg-server" {
  name                         = "n01702697-postgresql-srv"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  sku_name                     = var.sku_name
  version                      = "11"  # PostgreSQL version
  storage_mb                   = var.storage_mb
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  ssl_enforcement_enabled = true

  tags = var.tags
}

resource "azurerm_postgresql_database" "pg-db" {
  name                = var.database_name
  server_name         = azurerm_postgresql_server.pg-server.name
  resource_group_name = var.resource_group_name
  charset             = "UTF8"
  collation           = "en_US.utf8"
}

