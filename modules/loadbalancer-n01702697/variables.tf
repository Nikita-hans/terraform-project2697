variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "vm_network_interfaces" {
  description = "The network interfaces of the VMs to be attached to the load balancer"
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
}
