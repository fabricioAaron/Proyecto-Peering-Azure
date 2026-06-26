terraform {
  required_providers { #aquí se definen los proveedores que se van a utilizar, en este caso el proveedor de Azure
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.65.0"
    }
  }

  required_version = ">=1.14.0" #aquí se define la versión mínima de terraform que se requiere para ejecutar este código
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true #sirve para habilitar el borrado suave de los key vaults
      recover_soft_deleted_key_vaults = true #sirve para habilitar la recuperación de los key vaults
    }
  }
}
