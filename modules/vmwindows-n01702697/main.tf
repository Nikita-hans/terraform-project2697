resource "azurerm_availability_set" "availability_set" {
  name                         = "n01702697-w-AVSet"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  managed                      = true
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5

  tags = var.tags  # Apply the tags from root module
}

resource "azurerm_public_ip" "public_ip" {
  count               = var.vm_count
  name                = "n01702697-w-pip-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Basic"
  domain_name_label   = "n01702697-w-vm-${count.index + 1}"  # Unique DNS label

  tags = var.tags  # Apply the tags from root module
}

resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "n01702697-w-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                    = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id         = azurerm_public_ip.public_ip[count.index].id
  }

  tags = var.tags  # Apply the tags from root module
}

resource "azurerm_windows_virtual_machine" "vm" {
  count               = var.vm_count
  name                = "n01702697-w-vm-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1ms"  # Define the VM size
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]
  availability_set_id = azurerm_availability_set.availability_set.id
  computer_name = "windows-vm-${count.index + 1}"
  os_disk {
    name              = "n01702697-w-osdisk-${count.index + 1}"
    caching           = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  winrm_listener {
    protocol = "Http"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  tags = var.tags  # Apply the tags from root module
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  count = var.vm_count
  name                 = "AntiMalwareExtension-${count.index + 1}"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm[count.index].id
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.5"
}