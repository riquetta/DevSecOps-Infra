output "resource_group" {
value = azurerm_resource_group.rg.name
}


output "storage_account_id" {
value = azurerm_storage_account.st.id
}


output "aks_cluster_name" {
value = azurerm_kubernetes_cluster.aks.name
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "subscription_id_from_keyvault" {
  value     = data.azurerm_key_vault_secret.sub_id.value
  sensitive = true
}