package main #terraform.azure.encryption

default deny := false

checkenc[msg] if {
	some resource in input.resource_changes
	resource.type == "azurerm_managed_disk"
	attrs := resource.change.after
	not attrs.disk_encryption_set_id
	msg = sprintf("Managed disk %v does not have disk_encryption_set_id set", [resource.address])
}

checknodeenc[msg] if {
	some resource in input.resource_changes
	resource.type == "azurerm_kubernetes_cluster"
	attrs := resource.change.after
	not attrs.default_node_pool[0].disk_encryption_set_id
	msg = sprintf("AKS cluster %v default_node_pool is missing disk_encryption_set_id", [resource.address])
}

