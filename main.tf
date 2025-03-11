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
  location            = "East US"
  resource_group_name = module.rgroup-2697.resource_group_name
  subnet_id           = module.network-2697.subnet_id
  storage_account_uri = module.common-2697.storage_account_uri
  public_key          = "~/.ssh/id_rsa.pub"
  vm_names            = {
    "vm1" = "n01702697-centos-vm1"
  }
}

module "vmwindows-n01702697" {
  source              = "./modules/vmwindows-n01702697"
  location            = "East US"
  resource_group_name = module.rgroup-2697.resource_group_name
  subnet_id           = module.network-2697.subnet_id
  storage_account_uri = module.common-2697.storage_account_uri
  vm_count = 1
  tags = local.tags
  vm_admin_username = "n01702697"
  vm_admin_password = "Winadm!23"
}

module "data_disk-2697" {
  source              = "./modules/datadisk-n01702697"
  location            = "East US"
  resource_group_name = module.rgroup-2697.resource_group_name
  virtual_machine_ids = concat(
    module.vmlinux-n01702697.vm_ids,
    module.vmwindows-n01702697.vm_ids
  )
  disk_count = 2
  tags = local.tags
}

module "loadbalancer-n01702697" {
  source              = "./modules/loadbalancer-n01702697"
  location            = "East US"
  resource_group_name = module.rgroup-2697.resource_group_name
  vm_network_interfaces = module.vmlinux-n01702697.vm_nic_ids
  tags = local.tags
}

module "database-2697" {
  source              = "./modules/database-n01702697"
  location            = "East US"
  resource_group_name = module.rgroup-2697.resource_group_name
  sku_name            = "B_Gen5_1"
  admin_login         = "adminuser"
  admin_password      = "Dbadm!23"
  database_name       = "n01702697_db"
  tags                = local.tags
}


