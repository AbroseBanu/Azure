
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "vnetcreation" {
  name     = "example-resources"
  location = "West Europe"

}

# Create a network security group
resource "azurerm_network_security_group" "vnetcreation" {
  name                = "example-security-group"
  location            = azurerm_resource_group.vnetcreation.location
  resource_group_name = azurerm_resource_group.vnetcreation.name
}

# Create a virtual network with custom DNS servers and subnets
resource "azurerm_virtual_network" "vnetcreation" {
  name                = "example-network"
  location            = azurerm_resource_group.vnetcreation.location
  resource_group_name = azurerm_resource_group.vnetcreation.name
  address_space       = ["10.0.0.0/16"]
  

  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.vnetcreation.id
  }

  tags = {
    environment = "Production"
  }
}
