variable "id_rsa_pub" {
  description = "Contents of id_rsa.pub file for SSH access"
  default = "id_rsa.pub"
}

variable "location" {
  description = "The location where resources are created"
  default     = "East US"
}

variable "packer_resource_group_name" {
  description = "Resource Group name for packer images"
  default     = "Kawsar-Azure-Packer-081018"
}

variable "core_resource_group_name" {
  description = "Name for core resource group"
  default = "azure-vmss-core"
}

variable "app_resource_group_name" {
  description = "Name for app resource group"
  default = "azure-vmss-app"
}

variable "image_name" {
  description = "The name of OS image to use"
  default     = "vmss-packer-ubuntu1604-lts"
}

#Azure provider configured via Environment variables
provider "azurerm" { }

#Instantiate core module:
module "core-dev-network" {
  source = "./modules/core"
  location = "${var.location}"
  core_resource_group_name = "${var.core_resource_group_name}"
  tags = {
    environment = "dev"
    owner       = "kawsar-at-hashicorp"
    ttl         = "24h"
    app         = "vmss-packer-stack"
    client      = "multiple"
  }
  id_rsa_pub = "${var.id_rsa_pub}"
}

#Instantiate App module:
module "acme-app" {
  source = "./modules/app"
  
  #Packer related variables:
  packer_resource_group_name = "${var.packer_resource_group_name}"
  image_name = "${var.image_name}"

  #Core workspace:
  core_tfe_organization="kawsar-org"
  core_infrastructure_workspace="terraform-vmss-core"

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
  vmss_capacity = 2
}
