variable "location" {
  description = "Azure region for deployment"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  default     = {}
}

