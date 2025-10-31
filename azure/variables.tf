variable "location" {
type = string
default = "canadacentral"
}


variable "resource_group_name" {
type = string
default = "rg-aks-demo"
}


variable "tags" {
type = map(string)
default = {
Owner = "marcos"
Env = "dev"
}
}
variable "storage_account_name" {
type = string
default = "staksdemodemo"
}


variable "aks_cluster_name" {
type = string
default = "aks-demo"
}


variable "enable_disk_encryption" {
type = bool
default = false
}


variable "disk_encryption_set_id" {
type = string
default = ""
}


# If you want to pass strings directly
variable "node_taints" {
  description = "List of taints in key=value:Effect form"
  type        = list(string)
  default     = [] # ok to leave empty
}

# OR, if you prefer structured input (key/value/effect) and render strings:
variable "node_taints_obj" {
  type = list(object({ key = string, value = string, effect = string }))
  default = []
}

variable "keyvault_name" {
  type = string
  default = "keyvault-tf-1"
  
}

variable "keyvault_resource_group_name" {
  description = "Name of the resource group containing the Key Vault"
  type        = string
  default     = "tf"
}

variable "subscription_id" {
  type = string
  #default = "subscription_id"
}