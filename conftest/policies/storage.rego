package main #terraform.azure.storage


# Reject storage accounts permitting public blob access or with public_network_access set to "Enabled".

#default deny := false

sto1[msg] if {
	some resource in input.resource_changes
	resource.type == "azurerm_storage_account"

	# path to attributes in terraform plan json: after running `terraform show -json`
	attrs := resource.change.after
	attrs.allow_blob_public_access == true
	msg = sprintf("Storage account %v allows public blob access", [resource.address])
}

sto2[msg] if {
	some resource in input.resource_changes
	resource.type == "azurerm_storage_account"
	attrs := resource.change.after
	attrs.public_network_access == "Enabled"
	msg = sprintf("Storage account %v has public_network_access enabled", [resource.address])
}

