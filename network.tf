resource "azurerm_virtual_network" "aks_network" {
  name                = "vnet_qdt_aks"
  location            = azurerm_resource_group.rg_qdt.location
  resource_group_name = azurerm_resource_group.rg_qdt.name
  address_space       = [local.vnet_prefix]

  tags = azurerm_resource_group.rg_qdt.tags
}

resource "azurerm_subnet" "kubesubnet" {
  name                 = "snet_qdt_aks"
  address_prefixes     = [local.snet_prefix]
  virtual_network_name = azurerm_virtual_network.aks_network.name
  resource_group_name  = azurerm_resource_group.rg_qdt.name
  depends_on           = [azurerm_virtual_network.aks_network]

}

resource "azurerm_role_assignment" "network" {
  scope                = azurerm_subnet.kubesubnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azuread_service_principal.aad_service_principal.object_id 

  depends_on = [azurerm_virtual_network.aks_network]
}