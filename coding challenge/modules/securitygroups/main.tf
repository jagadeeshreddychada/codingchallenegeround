#nsg for web subnet

resource "azurerm_network_security_group" "app2-nsg" {
  name                = "forapp2-nsg"
  location            = var.location
  resource_group_name = var.resource_group
  
  security_rule {
    name                       = "ssh-rule-inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "var.app1subnetcidr"
    source_port_range          = "22"
    destination_address_prefix = "var.app2subnetcidr"
    destination_port_range     = "22"
}

security_rule {
    name                       = "ssh-rule-inbound"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
}


}

resource "azurerm_subnet_network_security_group_association" "app2-nsg-subnet" {
  subnet_id                 = var.app2_subnet_id
  network_security_group_id = azurerm_network_security_group.app2-nsg.id
}