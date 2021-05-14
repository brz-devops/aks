resource "azurerm_kubernetes_cluster" "aks_qdt" {
  name                = "aks-qdt-${random_string.seed.result}"
  location            = azurerm_resource_group.rg_qdt.location
  resource_group_name = azurerm_resource_group.rg_qdt.name
  dns_prefix          = "aks-qdt-${random_string.seed.result}"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_B1S"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = azuread_service_principal.aad_service_principal.application_id
    client_secret = random_password.service_principal_password.result
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    kube_dashboard {
      enabled = true
    }
  }

  tags = {
    Environment = "POC"
  }
}
