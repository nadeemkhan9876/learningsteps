output "acr_server" {
  value = azurerm_container_registry.main.login_server
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.main.name
}

output "key_vault_uri" {
  value = azurerm_key_vault.main.vault_uri
}