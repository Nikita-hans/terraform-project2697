variable "location" {
  default = "Canada Central"
}

variable "resource_group_name" {
  default = "n01702697-RG"
}

variable "subnet_id" {}

variable "storage_account_uri" {}

variable "public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "vm_names" {
  default = {
    "vm1" = "n01702697-c-vm1"
    "vm2" = "n01702697-c-vm2"
  }
}

