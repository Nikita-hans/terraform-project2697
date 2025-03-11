resource "null_resource" "display_hostname" {
  for_each = var.vm_names

  provisioner "remote-exec" {
    inline = ["hostname"]

    connection {
      type        = "ssh"
      host        = azurerm_linux_virtual_machine.vmlinux[each.key].public_ip_address
      user        = "n01702697"
      private_key = file("~/.ssh/id_rsa")
    }
  }

  depends_on = [azurerm_linux_virtual_machine.vmlinux]
}

