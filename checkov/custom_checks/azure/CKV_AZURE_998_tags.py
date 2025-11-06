from checkov.common.models.enums import CheckResult, CheckCategories
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck


class RequireTags(BaseResourceCheck):
def __init__(self):
name = "Ensure resources have tags (Owner, Env)"
id = "CKV_AZURE_998"
supported_resources = ["azurerm_storage_account", "azurerm_kubernetes_cluster", "azurerm_resource_group"]
categories = [CheckCategories.GENERAL_SECURITY]
super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)


def scan_resource_conf(self, conf):
tags = conf.get('tags')
if not tags:
return CheckResult.FAILED
# tags may be a list representation; attempt to find Owner and Env
owner = False
env = False
if isinstance(tags, dict):
owner = 'Owner' in tags
env = 'Env' in tags
else:
# Terraform plan dicts sometimes use lists; do a loose check
txt = str(tags)
owner = 'Owner' in txt
env = 'Env' in txt


if not owner or not env:
return CheckResult.FAILED
return CheckResult.PASSED


check = RequireTags()