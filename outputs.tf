# Output para mostrar los nombres de las máquinas virtuales creadas
output "vm_names" {
  description = "Nombres de las Máquinas Virtuales"
  value       = azurerm_virtual_machine.main[*].name #el * es para que se muestren todas las máquinas virtuales, ya que usasmos un count
}

# Output para mostrar las IPs privadas de las tarjetas de red de las VMs
output "vm_private_ips" {
  description = "Direcciones IP Privadas de las VMs"
  value       = azurerm_network_interface.main[*].private_ip_address
}

# Output para mostrar el nombre exacto del Key Vault que se creó
output "key_vault_name" {
  description = "Nombre del Key Vault"
  value       = azurerm_key_vault.key_vault.name
}

# Output para mostrar la URI del Key Vault 
output "key_vault_uri" {
  description = "URI del Key Vault"
  value       = azurerm_key_vault.key_vault.vault_uri
}
