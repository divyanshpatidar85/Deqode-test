
resource "azurerm_resource_group" "nomad" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }
}


resource "azurerm_virtual_network" "vnet" {
  name                = "nomad-vnet"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.nomad.name
  tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }
}


resource "azurerm_subnet" "nomad_subnet" {
  name                 = "nomad-subnet"
  resource_group_name  = azurerm_resource_group.nomad.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes
}


resource "azurerm_network_security_group" "nomad_nsg" {
  name                = "nomad-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.nomad.name
  tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.ssh_source_cidr
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "NomadHTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4646"
    source_address_prefix      = var.nomad_ui_source_cidr
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "NomadRPC"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4647"
    source_address_prefix      = var.vnet_address_space[0]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "NomadSerf"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4648"
    source_address_prefix      = var.vnet_address_space[0]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ConsulHTTP"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8500"
    source_address_prefix      = var.vnet_address_space[0]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ConsulDNS"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8600"
    source_address_prefix      = var.vnet_address_space[0]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HelloWorldApp"
    priority                   = 160
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = var.nomad_ui_source_cidr
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAllOutbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_public_ip" "nomad_server_ips" {
  count               = var.server_count
  name                = "nomad-server-ip-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.nomad.name
  allocation_method   = "Static"
  sku                = "Standard"
  tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }
}


resource "azurerm_public_ip" "nomad_client_ips" {
  count               = var.client_count
  name                = "nomad-client-ip-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.nomad.name
  allocation_method   = "Static"
  sku                = "Standard"
  tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }
}


resource "azurerm_network_interface" "nomad_server_nics" {
  count               = var.server_count
  name                = "nomad-server-nic-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.nomad.name
  tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }

  ip_configuration {
    name                          = "internal-${count.index}"
    subnet_id                     = azurerm_subnet.nomad_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.${10 + count.index}"
    public_ip_address_id          = azurerm_public_ip.nomad_server_ips[count.index].id
  }
}

resource "azurerm_network_interface" "nomad_client_nics" {
  count               = var.client_count
  name                = "nomad-client-nic-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.nomad.name
  tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }

  ip_configuration {
    name                          = "internal-${count.index}"
    subnet_id                     = azurerm_subnet.nomad_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.${20 + count.index}"
    public_ip_address_id          = azurerm_public_ip.nomad_client_ips[count.index].id
  }
}


resource "azurerm_network_interface_security_group_association" "nomad_server_nsg_association" {
  count                     = var.server_count
  network_interface_id      = azurerm_network_interface.nomad_server_nics[count.index].id
  network_security_group_id = azurerm_network_security_group.nomad_nsg.id
}


resource "azurerm_network_interface_security_group_association" "nomad_client_nsg_association" {
  count                     = var.client_count
  network_interface_id      = azurerm_network_interface.nomad_client_nics[count.index].id
  network_security_group_id = azurerm_network_security_group.nomad_nsg.id
}

resource "random_string" "nomad_bootstrap_token" {
  length  = 32
  special = false
}


resource "azurerm_linux_virtual_machine" "nomad_servers" {
  count               = var.server_count
  name                = "nomad-server-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.nomad.name
  size                = var.vm_size
  admin_username      = var.admin_username
  tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
    Role        = "nomad-server"
  }

  network_interface_ids = [
    azurerm_network_interface.nomad_server_nics[count.index].id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 50
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("scripts/install_nomad_server.sh", {
    server_count = var.server_count
    server_ips   = [for i in range(var.server_count) : "10.0.1.${10 + i}"]
    current_ip   = "10.0.1.${10 + count.index}"
    bootstrap_token = random_string.nomad_bootstrap_token.result
  }))
}


resource "azurerm_linux_virtual_machine" "nomad_clients" {
  count               = var.client_count
  name                = "nomad-client-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.nomad.name
  size                = var.vm_size
  admin_username      = var.admin_username
  tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
    Role        = "nomad-client"
  }

  network_interface_ids = [
    azurerm_network_interface.nomad_client_nics[count.index].id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 50
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("scripts/install_nomad_client.sh", {
    server_ips = [for i in range(var.server_count) : "10.0.1.${10 + i}"]
    current_ip = "10.0.1.${20 + count.index}"
    bootstrap_token = random_string.nomad_bootstrap_token.result
  }))
}