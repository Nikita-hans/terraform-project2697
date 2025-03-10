variable "location" {
  description = "Azure region to deploy the resources."
}

variable "resource_group_name" {
  description = "Name of the resource group."
}

variable "vnet_address_space" {
  description = "Address space for the virtual network."
}

variable "subnet_address_space" {
  description = "Address prefix for the subnet."
}

variable "tags" {
  description = "Tags to assign to the resources"
  type        = map(string)
  default     = {}
}
