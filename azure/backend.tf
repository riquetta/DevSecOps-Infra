terraform {
  backend "azurerm" {
    resource_group_name   = "sto"
    storage_account_name  = "sto20251022"     # Replace with your actual one
    container_name        = "tfstate"
    key                   = "infra.tfstate"
  }
}


provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}
