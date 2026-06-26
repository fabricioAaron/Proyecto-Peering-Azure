# Creación de las interfaces de red para las máquinas virtuales
resource "azurerm_network_interface" "main" {
  count               = var.vm_count
  name                = "peer${count.index + 1}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name = "testconfiguration1"
    # element() evita errores si el número de VMs supera el de subredes disponibles
    subnet_id                     = element([azurerm_subnet.sn1.id, azurerm_subnet.sn2.id], count.index)
    private_ip_address_allocation = "Dynamic"
  }
}

# Creación de las máquinas virtuales
resource "azurerm_virtual_machine" "main" {
  count                 = var.vm_count
  name                  = "peer${count.index + 1}-vm${count.index + 1}" #la diferencia de usar ${count.index + 1} es para que se diferencie de la primera maquina virtual de la segunda maquina virtual
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.main[count.index].id] #la diferencia de usar [count.index] es para que se diferencie de la primera maquina virtual de la segunda maquina virtual
  vm_size               = "Standard_B2als_v2"

  # Elimina el disco del sistema operativo automáticamente cuando se elimina la máquina virtual
  delete_os_disk_on_termination = true

  # Sirve para eliminar los discos de datos automáticamente cuando se elimina la máquina virtual
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk-${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = azurerm_key_vault_secret.password.value
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    # Mantenemos "staging" para la primera VM (1) y "dev" para la segunda (2), tal como en el original
    environment = count.index == 1 ? "staging" : "dev"
  }
}
