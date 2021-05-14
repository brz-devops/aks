resource "azurerm_user_assigned_identity" "aks_identity" {
  resource_group_name = azurerm_resource_group.rg_qdt.name
  location            = azurerm_resource_group.rg_qdt.location
  name                = "mid-qdt-aks-${random_string.seed.result}"

  tags = azurerm_resource_group.rg_qdt.tags
}