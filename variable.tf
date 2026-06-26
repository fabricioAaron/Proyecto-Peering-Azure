variable "location" {
  description = "Ubicación de los recursos"
  type        = string
  default     = "spain central"
}

variable "vm_count" {
  type    = number
  default = 2
}

variable "keyvault_name" {
  type    = string
  default = "keyvaulpass"
}

variable "keyvault_location" {
  type    = string
  default = "spain central"
}

variable "keyvault_resource_group_name" {
  type    = string
  default = "proyecto_peering"
}

variable "name_pass" {
  type    = string
  default = "vmpass"
}

variable "password" {
  description = "contraseña para las mv"
  type        = string
  sensitive   = true #esto hace que la contraseña no se muestre en la terminal
}
