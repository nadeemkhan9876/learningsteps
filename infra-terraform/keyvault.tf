data "azurerm_client_config" "current" {}   # reads who is logged in

resource "azurerm_key_vault" "main" {
  name                      = var.kv_name
  location                  = azurerm_resource_group.main.location
  resource_group_name       = azurerm_resource_group.main.name
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = "standard"
  enable_rbac_authorization = true
  purge_protection_enabled  = false          # dev: let destroy actually delete
}

resource "azurerm_role_assignment" "kv_secrets_officer" {
  principal_id         = data.azurerm_client_config.current.object_id
  role_definition_name = "Key Vault Secrets Officer"
  scope                = azurerm_key_vault.main.id
}

resource "azurerm_key_vault_secret" "db_conn" {
  name         = "db-connection-string"
  value        = "postgresql://${var.db_admin}:${var.db_password}@${azurerm_postgresql_flexible_server.main.fqdn}:5432/learningsteps?sslmode=require"
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_role_assignment.kv_secrets_officer]   # role before write
}