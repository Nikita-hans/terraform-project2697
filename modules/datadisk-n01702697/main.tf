resource "azurerm_managed_disk" "data_disk" {
  count               = var.disk_count
  name                = "n01702697-data-disk-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  disk_size_gb = 10
  storage_account_type = "Standard_LRS"
  create_option       = "Empty"
  tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment" {
  count               = var.disk_count
  virtual_machine_id  = var.virtual_machine_ids[count.index]
  managed_disk_id     = azurerm_managed_disk.data_disk[count.index].id
  lun                 = count.index
  caching             = "ReadWrite"
}
