resource "azurerm_availability_set" "linux_avs" {
  name                         = "n01702697-availability-set"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}

resource "azurerm_public_ip" "linux_pip" {
  for_each = var.vm_names
  name                = "${each.value}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = each.value
}

resource "azurerm_network_interface" "linux_nic" {
  for_each = var.vm_names
  name                = "${each.value}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "vmlinux" {
  for_each = var.vm_names
  name                = each.value
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  network_interface_ids = [
    azurerm_network_interface.linux_nic[each.key].id
  ]
  availability_set_id = azurerm_availability_set.linux_avs.id

  admin_username = "n01702697"
  admin_ssh_key {
    username   = "n01702697"
    public_key = file(var.public_key)
  }

  os_disk {
    name                 = "${each.value}-os-disk"
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
  for_each = var.vm_names
  name                 = "NetworkWatcher-${each.value}"
  virtual_machine_id   = azurerm_linux_virtual_machine.vmlinux[each.key].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each = var.vm_names
  name                 = "AzureMonitor-${each.value}"
  virtual_machine_id   = azurerm_linux_virtual_machine.vmlinux[each.key].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.9"
}

