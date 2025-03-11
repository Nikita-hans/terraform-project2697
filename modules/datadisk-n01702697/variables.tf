variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure location where resources will be created"
  type        = string
}

variable "virtual_machine_ids" {
  description = "The list of VM IDs to attach disks to"
  type        = list(string)
}


variable "disk_count" {
  description = "The count of disks"
  type = number
}

variable "tags" {
  description = "value of tags"
  type = map(string)
}