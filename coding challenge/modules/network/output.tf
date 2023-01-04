output "network_name" {
  value = azurerm_virtual_network.vnet01.name
  description = "Name of the Virtual network"
}

output "app1subnet_id" {
  value = azurerm_subnet.app1-subnets.id
  description = "Id of websubnet in the network"
}

output "app2subnet_id" {
  value = azurerm_subnet.app2-subnets.id
  description = "Id of appsubnet in the network"
}

