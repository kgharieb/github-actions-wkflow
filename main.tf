

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

resource "azurerm_network_interface" "example" {
  name                = "alpaslan-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sub1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "alpaslan-machine"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_password                  = "Password1234!"
  disable_password_authentication = false

  os_disk {
    name                 = "example-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

output "vnet_id" {
  value = azurerm_virtual_network.kgeek_tst.id
}