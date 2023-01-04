# creating NIC card for our  vms in app1 tier

resource "azurerm_network_interface" "app1-niccard" {

    name = "app1-nic"
    resource_group_name = var.resource_group
    location = var.location

    ip_configuration {
      name = "external1"
      subnet_id = var.app1_subnet_id
      private_ip_address_allocation = "Dynamic"

    }

# creating vm for our app1 tier

resource "azurerm_virtual_machine" "app1-vms" {
    count = var.countnumber
    name = "vm1"
    resource_group_name = var.resource_group
    location = var.location
    network_interface_ids = azurerm_network_interface.app1niccard.id 
    vm_size = "Standard_D2s_v3"

    storage_image_reference {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }

    storage_os_disk {
      name = "app-disk-1"
      managed_disk_type = "Standard_LRS"
      create_option     = "FromImage"
    }

    os_profile {
      computer_name  = "appserver1"
      admin_username = "app1admin"
      admin_password = "Password1234!"
    }
    os_profile_linux_config {
      disable_password_authentication = false
    }
}


#################################################

}

# creating NIC card for our  vms in app2 tier

resource "azurerm_network_interface" "app2-niccard" {

    name = "app2-nic"
    resource_group_name = var.resource_group
    location = var.location

    ip_configuration {
      name = "external2"
      subnet_id = var.app2_subnet_id
      private_ip_address_allocation = "Dynamic"

    }
}
# creating vm for our app2 tier

resource "azurerm_virtual_machine" "app2-vms" {
    name = "vm2"
    resource_group_name = var.resource_group
    location = var.location
    network_interface_ids = [azurerm_network_interface.app2-niccard.id]
    vm_size = "Standard_D2s_v3"

    storage_image_reference {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }

    storage_os_disk {
      name = "app-disk2"
      managed_disk_type = "Standard_LRS"
      create_option     = "FromImage"
    }

    os_profile {
      computer_name  = "app2server"
      admin_username = "app2admin"
      admin_password = "Password1234!"
    }
    os_profile_linux_config {
      disable_password_authentication = false
    }
}
