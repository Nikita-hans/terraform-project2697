resource "null_resource" "display_hostname" {
  count = 3

  provisioner "remote-exec" {
    inline = ["hostname"]

    connection {
      type        = "ssh"
      host        = azurerm_public_ip.linux_pip[count.index].ip_address
      user        = "n01702697"
      private_key = file("/home/n01702697/.ssh/id_rsa")
    }
  }

  depends_on = [azurerm_linux_virtual_machine.vmlinux]
}

