variable "resource_group_name" {
  type    = string
  default = "docker"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "vmsize" {
  type    = string
  default = "Standard_B1ms"
}
