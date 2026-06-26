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
  default = "peeringkeyvault"
}

variable "keyvault_location" {
  type    = string
  default = "spain central"
}

variable "keyvault_resource_group_name" {
  type    = string
  default = "peering-demo"
}

variable "name_pass" {
  type    = string
  default = "vmpass"
}
