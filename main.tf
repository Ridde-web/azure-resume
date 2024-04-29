# 1. We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# 2. Configure the AzureRM Provider
provider "azurerm" {        # The AzureRM Provider supports authenticating using via the Azure CLI
    features {              # The features block allows changing the behaviour of the Azure Provider
      
    }
  
}

# 3. Create a resource group
resource "azurerm_resource_group" "mrc-rg" {
  name     = "myresumechallenge-rg"
  location = "North Europe"
}

#. Create Storage Account for
