data "azurerm_client_config" "current" {} #Ese bloque data se encarga de ir a Azure (usando la cuenta con la que hiciste az login en tu terminal) y obtener automáticamente tu tenant_id y tu object_id. De esta manera tu código es mucho más seguro y dinámico, porque no dejas expuesto el ID de tu organización.


resource "azurerm_key_vault" "key_vault" {
  name                        = var.keyvault_name
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true #sirve para habilitar el cifrado de disco de azure
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  depends_on = [
    azurerm_resource_group.rg
  ]

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get", "Set", "List", "Delete"
    ]

    storage_permissions = [
      "Get"
    ]
  }
}


resource "azurerm_key_vault_secret" "password" {
  name         = var.name_pass
  key_vault_id = azurerm_key_vault.key_vault.id
  value        = "Password1234!"
}
