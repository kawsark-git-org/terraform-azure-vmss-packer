output "redis_cache" {
  value = "${azurerm_redis_cache.vmss_redis.hostname}:${azurerm_redis_cache.vmss_redis.port}"
}
