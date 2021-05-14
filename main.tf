resource "azurerm_resource_group" "rg_qdt" {
  name = "rg-qdt-aks"
  location = "West Europe"
}

resource "random_string" "seed" {
  length           = 6
  special          = false
}


data "azurerm_subscription" "subscription" {}

data "azuread_user" "userids_admins" {
  count      = length(local.accesspolicy_admins)
  mail_nickname = "${replace(local.accesspolicy_admins[count.index], "@", "_")}#EXT#"
}

data "azuread_user" "userids_readers" {
  count      = length(local.accesspolicy_readers)
  mail_nickname = "${replace(local.accesspolicy_readers[count.index], "@", "_")}#EXT#"
}

