

provider "azurerm" {
  features {}
  use_oidc = true
}

resource "azurerm_resource_group" "main" {
  name     = "rg-kgeek-tst"
  location = "West Europe"
  tags = {
    Environment = "Testing"
    Owner       = "kgeek"
    Project     = "Terraform"
  }
}

resource "azurerm_virtual_network" "kgeek_tst" {
  name                = "kgeek-tst"
  address_space       = ["172.16.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "sub1" {
  name                 = "sub1"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.kgeek_tst.name
  address_prefixes     = ["172.16.1.0/24"]
}

resource "azurerm_subnet" "sub2" {
  name                 = "sub2"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.kgeek_tst.name
  address_prefixes     = ["172.16.2.0/24"]
}

resource "azurerm_subnet" "sub3" {
  name                 = "sub3"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.kgeek_tst.name
  address_prefixes     = ["172.16.3.0/24"]
}

output "vnet_id" {
  value = azurerm_virtual_network.kgeek_tst.id
}