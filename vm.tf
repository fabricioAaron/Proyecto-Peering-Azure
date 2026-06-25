#Creación de la interfaz de red para la máquina virtual 1   
resource "azurerm_network_interface" "main1" {
  name                = "peer1-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.sn1.id #sirve para conectar la máquina virtual a la subred, en este caso con la red sn1
    private_ip_address_allocation = "Dynamic"             #sirve para asignar una dirección ip dinámica a la máquina virtual
  }
}

#Creación de la máquina virtual 1 
resource "azurerm_virtual_machine" "main1" {
  name                  = "peer1-vm1"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.main1.id] #sirve para conectar la máquina virtual a la interfaz de red
  vm_size               = "Standard_B2als_v2"

  #Elimina el disco del sistema operativo automáticamente cuando se elimina la máquina virtual
  delete_os_disk_on_termination = true

  #Comenta la siguiente línea para eliminar los discos de datos automáticamente cuando se elimina la máquina virtual
  #delete_data_disks_on_termination = true

  storage_image_reference {                    #sirve para configurar la imagen del sistema operativo
    publisher = "Canonical"                    #sirve para configurar el editor de la imagen, en este caso Canonical
    offer     = "0001-com-ubuntu-server-jammy" #sirve para configurar la oferta de la imagen, en este caso Ubuntu Server Jammy
    sku       = "22_04-lts"                    #sirve para configurar la sku de la imagen, en este caso Ubuntu Server Jammy 22.04 LTS
    version   = "latest"                       #sirve para configurar la versión de la imagen, en este caso la última
  }
  storage_os_disk {                    #sirve para configurar el disco del sistema operativo
    name              = "myosdisk1"    #nombre del disco del sistema operativo
    caching           = "ReadWrite"    #sirve para habilitar la caché de lectura y escritura
    create_option     = "FromImage"    #sirve para crear el disco del sistema operativo desde una imagen
    managed_disk_type = "Standard_LRS" #sirve para configurar el tipo de disco del sistema operativo, en este caso Standard_LRS
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}

#####


#Creación de la interfaz de red para la máquina virtual 2  
resource "azurerm_network_interface" "main2" {
  name                = "peer2-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.sn2.id #sirve para conectar la máquina virtual a la subred, en este caso con la red sn1
    private_ip_address_allocation = "Dynamic"             #sirve para asignar una dirección ip dinámica a la máquina virtual
  }
}

#Creación de la máquina virtual 2 
resource "azurerm_virtual_machine" "main2" {
  name                  = "peer2-vm2"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.main2.id] #sirve para conectar la máquina virtual a la interfaz de red
  vm_size               = "Standard_B2als_v2"

  #Elimina el disco del sistema operativo automáticamente cuando se elimina la máquina virtual
  delete_os_disk_on_termination = true

  #Comenta la siguiente línea para eliminar los discos de datos automáticamente cuando se elimina la máquina virtual
  #delete_data_disks_on_termination = true

  storage_image_reference {                    #sirve para configurar la imagen del sistema operativo
    publisher = "Canonical"                    #sirve para configurar el editor de la imagen, en este caso Canonical
    offer     = "0001-com-ubuntu-server-jammy" #sirve para configurar la oferta de la imagen, en este caso Ubuntu Server Jammy
    sku       = "22_04-lts"                    #sirve para configurar la sku de la imagen, en este caso Ubuntu Server Jammy 22.04 LTS
    version   = "latest"                       #sirve para configurar la versión de la imagen, en este caso la última
  }
  storage_os_disk {                    #sirve para configurar el disco del sistema operativo
    name              = "myosdisk2"    #nombre del disco del sistema operativo
    caching           = "ReadWrite"    #sirve para habilitar la caché de lectura y escritura
    create_option     = "FromImage"    #sirve para crear el disco del sistema operativo desde una imagen
    managed_disk_type = "Standard_LRS" #sirve para configurar el tipo de disco del sistema operativo, en este caso Standard_LRS
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "dev"
  }
}



