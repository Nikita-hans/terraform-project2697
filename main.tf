module "rgroup-2697" {
  source = "./modules/rgroup-n01702697"  
  tags   = local.tags
}

module "network-2697" {
  source              = "./modules/network-n01702697" 
  location           = "East US"
  resource_group_name = module.rgroup-2697.resource_group_name
  vnet_address_space  = "10.0.0.0/16"
  subnet_address_space = "10.0.1.0/24"
}

module "common-2697" {
  source              = "./modules/common-n01702697"
  location            = "East US"
  resource_group_name = module.rgroup-2697.resource_group_name
  tags                = local.tags
}

module "vmlinux-n01702697" {
  source              = "./modules/vmlinux-n01702697"
  location            = module.rgroup-2697.location
  resource_group_name = module.rgroup-2697.resource_group_name
  subnet_id           = module.network-2697.subnet_id
  storage_account_uri = module.common-2697.storage_account_uri
  public_key          = "/home/n01702697/.ssh/id_rsa.pub"
}





