resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Basic"
  tags = var.tags
}

resource "azurerm_lb" "basic_lb" {
  name                     = "n01702697-basic-lb"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = "Basic"
  frontend_ip_configuration {
    name                            = "LoadBalancerFrontend"
    public_ip_address_id            = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name                     = "backend-pool"
  loadbalancer_id           = azurerm_lb.basic_lb.id
}

resource "azurerm_lb_probe" "health_probe" {
  name                     = "http-probe"
  loadbalancer_id           = azurerm_lb.basic_lb.id
  protocol                 = "Http"
  port                     = 80
  request_path             = "/"
  interval_in_seconds      = 15
  number_of_probes         = 2
}

resource "azurerm_lb_rule" "http_rule" {
  name                     = "http-rule"
  loadbalancer_id           = azurerm_lb.basic_lb.id
  protocol                 = "Tcp"
  frontend_port            = 80
  backend_port             = 80
  frontend_ip_configuration_name = azurerm_lb.basic_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids  = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                 = azurerm_lb_probe.health_probe.id
}

# Attach VMs to the Load Balancer's backend pool
resource "azurerm_network_interface_backend_address_pool_association" "vm_association" {
  count               = length(var.vm_network_interfaces)
  network_interface_id = var.vm_network_interfaces[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
  ip_configuration_name = "internal"
}
