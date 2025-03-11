terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01702697RG"
    storage_account_name = "tfstaten01702697sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}