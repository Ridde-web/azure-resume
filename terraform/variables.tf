# Location
variable "location" {
  type        = string
  description = "Azure region where all resources are created"
  default     = "northeurope"
}


# Resource Group Name
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group for storage account"
  default     = "azureresume-rg"
}

# Storage Account Name
variable "storage_account_name" {
  type        = string
  description = "Name of the storage account for the blob"
  default     = "dawidarcstorage"
}

# Index Document Name
variable "index_document" {
  type        = string
  description = "Name of the index document"
  default     = "index.html"
}

# Index HTML Path
variable "index_html_path" {
  type        = string
  description = "Source to the index.html"
  default     = "index.html"
}

# CDN Profile Name
variable "cdn_profile_name" {
  type        = string
  description = "Name of the CDN Profile"
  default     = "dawidcdnprofile"
}

# CDN Endpoint Name
variable "cdn_endpoint_name" {
  type        = string
  description = "Name of the CDN Endpoint"
  default     = "dawidcdnendpoint"
}

variable "origin_url" {
  type        = string
  description = "Url of the origin."
  default     = "www.dawid-it.se"
}