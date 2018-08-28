output "jumpbox_public_ip" {
    value = "${azurerm_public_ip.jumpbox.fqdn}"
}

output "app_public_ip" {
    value = "${azurerm_public_ip.vmss.fqdn}"
}

output "app_subnet_id" {
    value = "${azurerm_subnet.vmss.id}"
}

output "app_public_ip_id" {
    value = "${azurerm_public_ip.vmss.id}"
}

