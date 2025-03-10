resource "azurerm_availability_set" "linux_avs" {
  name                         = "n01702697-availability-set"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}

resource "azurerm_public_ip" "linux_pip" {
  count               = 3
  name                = "n01702697-vm${count.index + 1}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "n01702697-vm${count.index + 1}"
}

resource "azurerm_network_interface" "linux_nic" {
  count               = 3
  name                = "n01702697-vm${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal-ip-${count.index + 1}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[count.index].id
  }
}

resource "azurerm_linux_virtual_machine" "vmlinux" {
  count               = 3
  name                = "n01702697-vm${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  network_interface_ids = [
    azurerm_network_interface.linux_nic[count.index].id
  ]

  admin_username = "n01702697"
  admin_ssh_key {
    username   = "n01702697"
    public_key = file(var.public_key)
  }

  os_disk {
    name                 = "n01702697-vm${count.index + 1}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 32
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  count                = 3
  name                 = "NetworkWatcher-${count.index + 1}"
  virtual_machine_id   = azurerm_linux_virtual_machine.vmlinux[count.index].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.0"
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  count                = 3
  name                 = "AzureMonitor-${count.index + 1}"
  virtual_machine_id   = azurerm_linux_virtual_machine.vmlinux[count.index].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0"
}

