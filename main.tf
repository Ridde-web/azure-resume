# Fetches the configuration for current Azure client
data "azurerm_client_config" "current" {}

# 1. Create a resource group
resource "azurerm_resource_group" "arc-rg" {
  name     = "azureresume-rg"
  location = var.resource_group_location
}

# 2. Create a resource account
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

# 3. Create a resource container
resource "azurerm_storage_container" "static-page" {
  name = "static-web-page"
  storage_account_name  = azurerm_storage_account.arc-storage.name
  container_access_type = "private"
}

# 4. Create a blob
resource "azurerm_storage_blob" "html-code" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.arc-storage.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}