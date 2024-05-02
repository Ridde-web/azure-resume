# ======================================================================== #
# Fetches the configuration for current Azure client
# ======================================================================== #

data "azurerm_client_config" "current" {}

# ======================================================================== #
# Creates a Resource Group to logically contain resources
# ======================================================================== #

resource "azurerm_resource_group" "arc-rg" {
  name     = "azureresume-rg"
  location = var.location

  tags = {
    environment = "dev"
    source      = "Terraform"
  }
}

# ======================================================================== #
# Create a resource account
# ======================================================================== #

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

# ======================================================================== #
# Create a blob with index.html file
# ======================================================================== #

resource "azurerm_storage_blob" "blob" {
  name                   = var.index_document
  storage_account_name   = azurerm_storage_account.arc-storage.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = var.index_html_path
}

# ======================================================================== #
# Create a CDN Profile
# ======================================================================== #

resource "azurerm_cdn_profile" "cdn_profile" {
  name                = var.cdn_profile_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard_Microsoft"


}
# ======================================================================== #
# Create a CDN Enpoint
# ======================================================================== #

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = var.cdn_endpoint_name
  profile_name        = var.cdn_profile_name
  location            = var.location
  resource_group_name = var.resource_group_name
  is_http_allowed     = true
  is_https_allowed    = true


  origin {
    name      = var.cdn_endpoint_name
    host_name = var.origin_url

  }
}

# ======================================================================== #
# Create a CDN Custom Domain
# ======================================================================== #

