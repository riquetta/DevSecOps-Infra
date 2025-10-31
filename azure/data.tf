# Data source to get the Key Vault
data "azurerm_key_vault" "main" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_resource_group_name
}

# Retrieve the secret
data "azurerm_key_vault_secret" "sub_id" {
  name         = "subscription-id"
  key_vault_id = data.azurerm_key_vault.main.id
}

