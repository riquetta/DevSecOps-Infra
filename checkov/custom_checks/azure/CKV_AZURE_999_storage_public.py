from checkov.common.models.enums import CheckResult, CheckCategories
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck


class StorageNoPublicAccess(BaseResourceCheck):
def __init__(self):
name = "Ensure storage accounts do not allow public blob access"
id = "CKV_AZURE_999"
supported_resources = ["azurerm_storage_account"]
categories = [CheckCategories.GENERAL_SECURITY]
super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)


def scan_resource_conf(self, conf):
# conf is a dict-like representation of the resource
# Check allow_blob_public_access and public_network_access
allow_blob = conf.get('allow_blob_public_access')
public_network = conf.get('public_network_access')


if allow_blob is None and public_network is None:
return CheckResult.UNKNOWN


if allow_blob == ['true'] or allow_blob == True:
return CheckResult.FAILED


if public_network and (public_network == ['Enabled'] or public_network == 'Enabled'):
return CheckResult.FAILED


return CheckResult.PASSED


check = StorageNoPublicAccess()