resource "azurerm_virtual_network" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  subnet {
    name           = "subnet1"
    address_prefix = var.subnet_prefixes[0]
  }
}