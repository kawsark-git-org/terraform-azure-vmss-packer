variable "id_rsa_pub" {
  description = "Contents of id_rsa.pub file for SSH access"
  default = "id_rsa.pub"
}

variable "app_resource_group_name" {
  description = "Name for app resource group"
  default = "azure-vmss-app"
}

variable "location" {
  description = "The location where resources are created"
  default     = "East US"
}

variable "packer_resource_group_name" {
  description = "Resource Group name for packer images"
  default     = "Kawsar-Azure-Packer-081018"
}

variable "image_name" {
  description = "The name of OS image to use"
  default     = "vmss-packer-ubuntu1604-lts"
}

variable "core_tfe_organization" {
  description = "TFE organization"
  default = "kawsar-org"
}

variable "core_infrastructure_workspace" {
  description = "workspace to use for the core infrastructure"
  default = "terraform-vmss-core"
}

variable "vmss_capacity" {
  description = "The qty. of VMs in the application VM Scale Set"
  default     = 2
}

#Azure provider configured via Environment variables
provider "azurerm" { }

#Instantiate app module:
module "acme-app" {
  source = "github.com/kawsark-git-org/terraform-azure-vmss-packer/modules/app"
  
  #Packer related variables:
  packer_resource_group_name = "${var.packer_resource_group_name}"
  image_name = "${var.image_name}"

  #Core workspace:
  core_tfe_organization="${var.core_tfe_organization}"
  core_infrastructure_workspace="${var.core_infrastructure_workspace}"

  #Application Module specific variables:
  location = "${var.location}"
  app_resource_group_name = "${var.app_resource_group_name}"  

  tags = {
    environment = "dev"
    owner       = "kawsar-at-hashicorp"
    ttl         = "24h"
    app         = "Redis-client"
    client      = "ACME"
  }

  id_rsa_pub = "${var.id_rsa_pub}"
  vmss_capacity = "${var.vmss_capacity}"
}

output "redis_cache" {
  value = "${module.acme-app.redis_cache}"
}

output "app_public_ip" {
    value = "${module.acme-app.app_public_ip}"
}
