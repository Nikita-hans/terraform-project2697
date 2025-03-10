resource "azurerm_resource_group" "rg" {
  name     = "2697RG"  
  location = "East US" 

  tags = var.tags
}

