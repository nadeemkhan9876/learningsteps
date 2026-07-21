resource "azurerm_container_registry" "main" {
  name                = var.acr_name        # globally unique, alphanumeric only
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true                # CD logs in with ACR_USERNAME/ACR_PASSWORD
}