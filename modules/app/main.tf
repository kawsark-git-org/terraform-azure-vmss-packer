data "terraform_remote_state" "core_infrastructure" {
  backend = "atlas"
  config {
    name = "${var.core_tfe_organization}/${var.core_infrastructure_workspace}"
  }
}

resource "azurerm_resource_group" "app" {
  name     = "${var.app_resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}

resource "azurerm_lb" "vmss" {
  name                = "vmss-lb"
  location            = "${var.location}"
  resource_group_name = "${var.app_resource_group_name}"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = "${data.terraform_remote_state.core_infrastructure.public_ip_address_id}"
  }

  tags = "${var.tags}"
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  resource_group_name = "${var.app_resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.vmss.id}"
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "vmss" {
  resource_group_name = "${var.app_resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.vmss.id}"
  name                = "ssh-running-probe"
  port                = "${var.application_port}"
}

resource "azurerm_lb_rule" "lbnatrule" {
  resource_group_name            = "${var.app_resource_group_name}"
  loadbalancer_id                = "${azurerm_lb.vmss.id}"
  name                           = "http"
  protocol                       = "Tcp"
  frontend_port                  = "${var.frontend_port}"
  backend_port                   = "${var.application_port}"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.bpepool.id}"
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = "${azurerm_lb_probe.vmss.id}"
}

data "azurerm_resource_group" "image" {
  name = "${var.packer_resource_group_name}"
}

data "azurerm_image" "image" {
  name                = "${var.image_name}"
  resource_group_name = "${data.azurerm_resource_group.image.name}"
}

resource "azurerm_virtual_machine_scale_set" "vmss" {
  name                = "vmscaleset"
  location            = "${var.location}"
  resource_group_name = "${var.app_resource_group_name}"
  upgrade_policy_mode = "Manual"
  
  sku {
    name     = "Standard_DS1_v2"
    tier     = "Standard"
    capacity = "${var.vmss_capacity}"
  }

  storage_profile_image_reference {
    id="${data.azurerm_image.image.id}"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun          = 0
    caching        = "ReadWrite"
    create_option  = "Empty"
    disk_size_gb   = 10
  }

  os_profile {
    computer_name_prefix = "vmlab"
    admin_username       = "azureuser"
    admin_password       = "${var.admin_password}"
    custom_data = "${data.template_file.redis_client_start_script.rendered}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = "${var.id_rsa_pub}"
    }
  }

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name                                   = "IPConfiguration"
      subnet_id                              = "${data.terraform_remote_state.core_infrastructure.app_subnet_id}"
      load_balancer_backend_address_pool_ids = ["${azurerm_lb_backend_address_pool.bpepool.id}"]
    }
  }

  tags = "${var.tags}"
}

data "template_file" "redis_client_start_script" {
  template = "${file("${path.module}/redis-client-start.sh")}"

  vars {
    redis_host = "${azurerm_redis_cache.vmss_redis.hostname}"
    redis_port = "${azurerm_redis_cache.vmss_redis.port}"
    redis_password = "${azurerm_redis_cache.vmss_redis.primary_access_key}"
  }
}

# Random identifier needed for Redis to have globally unique name
resource "random_pet" "redis_cache_name" {
  prefix = "vmss-redis"
  separator = "-"
}


# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "vmss_redis" {
  name                = "${random_pet.redis_cache_name.id}"
  location            = "${var.location}"
  resource_group_name = "${var.app_resource_group_name}"
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = true
  redis_configuration {
    rdb_backup_enabled            = false
  }
}