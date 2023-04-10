terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.29.0"
    }
  }
}

provider "azurerm" {
  version = "3.29.0"
  features {}
}

resource "azurerm_resource_group" "tfstate_store_group" {
  name     = "tfstate-store-group"
  location = "UAE North"
}

resource "azurerm_storage_account" "demo_fstate_store" {
  name                     = "demotfstatestore"
  resource_group_name      = azurerm_resource_group.tfstate_store_group.name
  location                 = azurerm_resource_group.tfstate_store_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "demo"
  }
}

resource "azurerm_storage_container" "tfstate_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.demo_fstate_store.name
  container_access_type = "private"
}