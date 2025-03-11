variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}

variable "vm_admin_password" {
 description = "value of the password"
 type        = string 
}

variable "vm_admin_username" {
  description = "Admin password for the VM"
  type        = string
}

variable "storage_account_uri" {
  description = "URL of the storage account"
  type        = string
}