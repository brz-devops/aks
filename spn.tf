resource "random_password" "service_principal_password" {
  length   = 32
}

resource "azuread_application" "application" {
  display_name               = "POCAKSQDTServicePrincipal"
  available_to_other_tenants = false
}

resource "azuread_application_password" "applicaton_password" {
  application_object_id = azuread_application.application.id
  value                 = random_password.service_principal_password.result
  end_date              = "2025-01-01T00:00:00Z"
}


resource "azuread_service_principal" "aad_service_principal" {
  application_id = azuread_application.application.application_id
}

resource "azurerm_role_assignment" "service_principal_k8s" {
  scope                = azurerm_resource_group.rg_qdt.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.aad_service_principal.id
}

