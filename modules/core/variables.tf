variable "id_rsa_pub" {
  description = "contents of id_rsa.pub file for SSH access"
}

variable "location" {
  description = "The location where resources are created"
  default     = "East US"
}

variable "core_resource_group_name" {
  description = "Resource Group name, must be lowercase alphanumeric with hyphens as its used as domain_name_label as well"
  default     = "azure-vmss-core"
}

variable "tags" {
  description = "A set of tags to apply"
  type        = "map"
  default = {
    environment = "dev"
    owner       = "kawsar-at-hashicorp"
    ttl         = "24h"
    app         = "azure-vmss-core"
  }
}

variable "jumpbox_admin_password" {
    description = "Default password for azureuser"
    default = "t3rraf0rm"
}

