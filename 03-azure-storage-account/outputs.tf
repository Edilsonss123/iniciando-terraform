output "storage_account_id" {
  description = "Id da Storae Account cruada na Azure"
  value       = azurerm_storage_account.storage-account-terraform-edilson.id
}

output "sa_primary_access_key" {
  description = "Primary Access Key da Storae Account cruada na Azure"
  value       = azurerm_storage_account.storage-account-terraform-edilson.primary_access_key
  sensitive   = true
}