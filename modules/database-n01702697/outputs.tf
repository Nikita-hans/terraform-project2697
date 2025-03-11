output "db_server_name" {
  description = "The name of the PostgreSQL server"
  value       = azurerm_postgresql_server.pg-server.name
}

output "db_instance_name" {
  description = "value of PostgreSQL server name"
  value       = azurerm_postgresql_database.pg-db.name
}
