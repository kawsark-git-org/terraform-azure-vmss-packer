variable "location" {
  description = "The location where resources are created"
  default     = "East US"
}

variable "id_rsa_pub" {
  description = "Contents of id_rsa.pub file for SSH access"
}

variable "core_tfe_organization" {
  description = "TFE organization"
  default = "kawsar-org"
}

variable "core_infrastructure_workspace" {
  description = "workspace to use for the core infrastructure"
  default = "terraform-vmss-core"
}

variable "app_resource_group_name" {
  description = "Resource Group name, must be lowercase alphanumeric with hyphens as its used as domain_name_label as well"
  default     = "kawsar-0823-tf-vmss-packer"
}

variable "packer_resource_group_name" {
  description = "Resource Group name for packer images"
  default     = "Kawsar-Azure-Packer-081018"
}

variable "image_name" {
  description = "The name of OS image to use"
  default     = "vmss-packer-ubuntu1404"
}

variable "tags" {
  description = "A set of tags to apply"
  type        = "map"
  default = {
    environment = "codelab"
    owner       = "kawsar-at-hashicorp"
    ttl         = "24h"
    app         = "vmss-packer-stack"
  }
}

variable "frontend_port" {
    description = "The frontend port of the external Load Balancer"
    default     = 80
}

variable "application_port" {
    description = "The backend port where the application can be accessed"
    default     = 5000
}

variable "admin_password" {
    description = "Default password for azureuser"
    default = "t3rraf0rm"
}