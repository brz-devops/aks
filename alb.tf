resource "azurerm_public_ip" "pip_qdt" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.rg_qdt.location
  resource_group_name = azurerm_resource_group.rg_qdt.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb_qdt" {
  name                = "AKSLoadBalancer"
  location            = azurerm_resource_group.rg_qdt.location
  resource_group_name = azurerm_resource_group.rg_qdt.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.pip_qdt.id
  }
}