resource "azurerm_resource_group" "resource-group-terraform-edilson" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "storage-account-terraform-edilson" {
  name                     = azurerm_resource_group.resource-group-terraform-edilson.name
  resource_group_name      = var.storage_account_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags                     = local.common_tags
}

resource "azurerm_storage_container" "storage-container-terraform-edilson" {
  name                 = var.container_name
  storage_account_name = azurerm_storage_account.storage-account-terraform-edilson.name
}