from checkov.common.models.enums import CheckResult, CheckCategories
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck


class RequireDiskEncryption(BaseResourceCheck):
def __init__(self):
name = "Ensure managed disks and AKS node pools use disk_encryption_set_id"
id = "CKV_AZURE_997"
supported_resources = ["azurerm_managed_disk", "azurerm_kubernetes_cluster"]
categories = [CheckCategories.GENERAL_SECURITY]
super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)


def scan_resource_conf(self, conf):
# For managed_disk, check disk_encryption_set_id
if conf.get('disk_encryption_set_id'):
return CheckResult.PASSED


# For AKS, default_node_pool may include disk_encryption_set_id
if conf.get('default_node_pool'):
pool = conf.get('default_node_pool')
txt = str(pool)
if 'disk_encryption_set_id' in txt:
return CheckResult.PASSED


return CheckResult.FAILED


check = RequireDiskEncryption()