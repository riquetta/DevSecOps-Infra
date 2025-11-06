package main #terraform.azure.tags

# Require that resources include tags and at least the Owner and Env tag keys
#default deny = false


tag1[msg] if {
some resource in input.resource_changes
# only enforce on common resource types. extend as needed.
resource.type == "azurerm_storage_account"
attrs := resource.change.after
not attrs.tags
msg = sprintf("%v is missing tags", [resource.address])
}


tag2[msg] if {
some resource in input.resource_changes
resource.type == "azurerm_kubernetes_cluster"
attrs := resource.change.after
tags := attrs.tags
not tags.Owner
msg = sprintf("%v is missing the tag 'Owner'", [resource.address])
}


tag3[msg] if {
some resource in input.resource_changes
resource.type == "azurerm_kubernetes_cluster"
attrs := resource.change.after
tags := attrs.tags
not tags.Env
msg = sprintf("%v is missing the tag 'Env'", [resource.address])
}

