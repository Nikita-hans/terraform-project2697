variable "location" {
  description = "Azure region where the PostgreSQL server should be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the PostgreSQL server will be created"
  type        = string
}

variable "sku_name" {
  description = "The SKU for the PostgreSQL server (e.g. B_Gen5_1)"
  type        = string
}

variable "storage_mb" {
  description = "The amount of storage in MB for the PostgreSQL server"
  type        = number
  default     = 5120
}

variable "backup_retention_days" {
  description = "The number of days to retain backups"
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Enable Geo-redundant backup"
  type        = bool
  default     = false
}

variable "admin_login" {
  description = "Administrator login for the PostgreSQL server"
  type        = string
}

variable "admin_password" {
  description = "Password for the administrator login"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags for the PostgreSQL server"
  type        = map(string)
  default     = {}
}

variable "database_name" {
  description = "The name of the PostgreSQL database to create"
  type        = string
}
