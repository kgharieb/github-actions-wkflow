

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

resource "az_vm" "example" {
  name                  = "alpaslan-machine"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.example.id]
  subnet_id             = azurerm_subnet.sub1.id
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_os_disk {
    name              = "example-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

output "vnet_id" {
  value = azurerm_virtual_network.kgeek_tst.id
}