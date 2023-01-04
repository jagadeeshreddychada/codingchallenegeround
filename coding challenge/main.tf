# 1. Specify the version of the AzureRM Provider to use
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "azure-2tier" {
  name     = var.name
  location = var.location
}

module "network" {
  source         = "./modules/network"
  location       = azurerm_resource_group.azure-2tier.location
  resource_group = azurerm_resource_group.azure-2tier.name
  vnetcidr       = var.vnetcidr
  app1subnetcidr = var.app1subnetcidr
  app2subnetcidr =  var.app2subnetcidr
  
}

module "securitygroups" {
  source         = "./modules/securitygroups"
  location       = azurerm_resource_group.azure-3tier.location
  resource_group = azurerm_resource_group.azure-3tier.name  
  app2subnetcidr   = var.app2subnetcidr
  app2_subnet_id   = module.network.app2subnet_id
}

module "compute" {
  source         = "./modules/virtualmachines"
  location = azurerm_resource_group.azure-3tier.location
  resource_group = azurerm_resource_group.azure-3tier.name
  app1_subnet_id = module.network.app1subnet_id
  app2_subnet_id = module.network.app2subnet_id
  

}
