# Fetches the configuration for current Azure client
data "azurerm_client_config" "current" {}

# Provides the configuration for Azure Provider, its source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the AzureRM Provider
provider "azurerm" {
  features {}
}

# Creates a Resource Group to logically contain resources
resource "azurerm_resource_group" "arc-rg" {
  name     = "azureresume-rg"
  location = var.resource_group_location
  tags = {
    environment = "dev"
    source      = "Terraform"
  }
}

# Create a resource account
resource "azurerm_storage_account" "arc-storage" {
  name                            = "dawidarcstorage"
  resource_group_name             = azurerm_resource_group.arc-rg.name
  location                        = azurerm_resource_group.arc-rg.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  enable_https_traffic_only       = true
  allow_nested_items_to_be_public = true

  static_website {
    index_document = "index.html"
  }
}

# Create a resource container
resource "azurerm_storage_container" "static-page" {
  name                  = "static-web-page"
  storage_account_name  = azurerm_storage_account.arc-storage.name
  container_access_type = "private"
}

# Create a blob with index.html file
resource "azurerm_storage_blob" "html-code" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.arc-storage.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}