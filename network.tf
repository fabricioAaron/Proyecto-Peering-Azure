resource "azurerm_resource_group" "rg" {
  name     = "peering-demo"
  location = "spain central"
}

# Creación de la red virtual 1
resource "azurerm_virtual_network" "vnet1" {
  name                = "peer1-vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Creación de la subred 1
resource "azurerm_subnet" "sn1" {
  name                 = "peer1-sn"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.0.0/24"]

}

# Creacioón de la red vitual 2 

resource "azurerm_virtual_network" "vnet2" {
  name                = "peer2-vnet2"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Creación de la subred 2

resource "azurerm_subnet" "sn2" {
  name                 = "peer2-sn"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.1.0.0/24"]
}

#Peering entre vnet1 y vnet2, sirve para que las dos redes virtuales se comuniquen entre si
#como si fueran una sola red virtual, es decir que podemos asignar direcciones ip a las maquinas virtuales
#como si estuvieran en la misma red virtual

resource "azurerm_virtual_network_peering" "example-1" {
  name                      = "peer1to2"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id # el .id es para obtener el id de la red virtual, que sirve para identificarla en azure
}

#Peering entre vnet2 y vnet1

resource "azurerm_virtual_network_peering" "example-2" {
  name                      = "peer2to1"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
}
