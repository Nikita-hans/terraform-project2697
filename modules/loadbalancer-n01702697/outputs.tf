output "load_balancer_name" {
  description = "The name of the load balancer"
  value       = azurerm_lb.basic_lb.name
}
