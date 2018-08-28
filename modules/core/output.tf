output "jumpbox_public_ip" {
    value = "${azurerm_public_ip.jumpbox.fqdn}"
}

output "app_public_ip" {
    value = "${azurerm_public_ip.app.fqdn}"
}

output "app_subnet_id" {
    value = "${azurerm_subnet.app.id}"
}

output "app_public_ip_id" {
    value = "${azurerm_public_ip.app.id}"
}

