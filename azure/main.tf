
resource "azurerm_resource_group" "rg" {
name = var.resource_group_name
location = var.location
tags = var.tags
}


resource "azurerm_storage_account" "st" {
name = var.storage_account_name
resource_group_name = azurerm_resource_group.rg.name
location = azurerm_resource_group.rg.location
account_tier = "Standard"
account_replication_type = "LRS"


# Prevent public blob/container access
public_network_access_enabled = false


# Recommended: disable public network access and use private endpoints for production!
network_rules {
  default_action = "Deny"
}

tags = var.tags
}


resource "azurerm_kubernetes_cluster" "aks" {
name = var.aks_cluster_name
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
dns_prefix = "aksdemo"


default_node_pool {
name = "agentpool"
node_count = 1
vm_size = "Standard_D2s_v3"


# If you want to enforce disk encryption, provide a disk_encryption_set_id


# then inside default_node_pool: # Will be deprecated
#node_taints = [for t in var.node_taints_obj : "${t.key}=${t.value}:${t.effect}"]

}


identity {
type = "SystemAssigned"
}


tags = var.tags
}


# Note: For managed disks encryption at rest beyond platform-managed KEKs you need a Disk Encryption Set resource
# and pass disk_encryption_set_id to any azurerm_managed_disk or VMSS when required. We model the variable in variables.tf