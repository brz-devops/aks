locals {
  useradmins = concat(local.userids_admins, [])
}
resource "azurerm_key_vault" "kv_qdt" {

  name                        = "kv-qdt-${ random_string.seed.result }"
  location                    = azurerm_resource_group.rg_qdt.location
  resource_group_name         = azurerm_resource_group.rg_qdt.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_subscription.subscription.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "admin_access" {
  count = length(local.useradmins)
  key_vault_id = azurerm_key_vault.kv_qdt.id
  tenant_id = data.azurerm_subscription.subscription.tenant_id
  object_id = local.useradmins[count.index]

    key_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore"
    ]
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore"
    ]
    certificate_permissions = [
      "Backup",
      "Create",
      "Delete",
      "DeleteIssuers",
      "Get",
      "GetIssuers",
      "Import",
      "List",
      "ListIssuers",
      "ManageContacts",
      "ManageIssuers",
      "Purge",
      "Recover",
      "Restore",
      "SetIssuers",
      "Update"
    ]
 
}