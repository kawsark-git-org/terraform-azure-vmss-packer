output "redis_cache" {
  value = "${azurerm_redis_cache.vmss_redis.hostname}:${azurerm_redis_cache.vmss_redis.port}"
}

output "app_public_ip" {
    value = "${azurerm_public_ip.app.fqdn}"
}
