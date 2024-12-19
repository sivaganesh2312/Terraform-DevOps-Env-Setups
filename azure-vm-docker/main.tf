resource "azurerm_resource_group" "docker" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    CreatedBy = "LearningThoughts.io"
    Purpose   = "Learning"
  }
}

resource "azurerm_virtual_network" "docker" {
  name                = "docker-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.docker.location
  resource_group_name = azurerm_resource_group.docker.name
}

resource "azurerm_subnet" "public" {
  name                 = "public"
  resource_group_name  = azurerm_resource_group.docker.name
  virtual_network_name = azurerm_virtual_network.docker.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "docker" {
  name                = "docker-ip"
  location            = azurerm_resource_group.docker.location
  resource_group_name = azurerm_resource_group.docker.name
  allocation_method   = "Static"
  sku                 = "Standard"

}

# network security group to open all ports

resource "azurerm_network_security_group" "docker" {
  name                = "docker-nsg"
  location            = azurerm_resource_group.docker.location
  resource_group_name = azurerm_resource_group.docker.name

  security_rule {
    name                       = "AllowAll"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "docker" {
  name                = "docker-nic"
  location            = azurerm_resource_group.docker.location
  resource_group_name = azurerm_resource_group.docker.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.docker.id
  }
}

# associate network security group with network interface

resource "azurerm_network_interface_security_group_association" "docker" {
  network_interface_id      = azurerm_network_interface.docker.id
  network_security_group_id = azurerm_network_security_group.docker.id
}

resource "azurerm_linux_virtual_machine" "docker" {
  name                = "docker-machine"
  resource_group_name = azurerm_resource_group.docker.name
  location            = azurerm_resource_group.docker.location
  size                = var.vmsize
  admin_username      = "learningthoughts"
  network_interface_ids = [
    azurerm_network_interface.docker.id,
  ]

  admin_ssh_key {
    username   = "learningthoughts"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  user_data = filebase64("installdocker.sh")
}