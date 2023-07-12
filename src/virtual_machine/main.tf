provider "azurerm" {
  features {}
}

module "resource_group" {
  source     = "../../modules/resource_group"
  name       = var.rg_name
  location   = var.location
}

module "network" {
  source               = "../../modules/virtual_network"
  resource_group_name  = module.resource_group.name
  name                 = var.vnet_name
  address_space        = var.add_space
  subnet_prefixes      = var.snet_prefix
}

module "public_ip" {
  source              = "../../modules/public_ip"
  resource_group_name = module.resource_group.name
  name                = var.pub_ip_name
}

module "network_interface" {
  source                      = "../../modules/network_interface"
  resource_group_name         = module.resource_group.name
  name                        = var.net_interface
  virtual_network_subnet_id   = module.network.subnet_id
  public_ip_address_id        = module.public_ip.public_ip_id
}

module "virtual_machine" {
  source                  = "../../modules/virtual_machine"
  resource_group_name     = module.resource_group.name
  name                    = "my-vm"
  network_interface_id    = module.network_interface.network_interface_id
  admin_username          = "adminuser"
  admin_password          = "P@ssw0rd123!"
  vm_size                 = "Standard_B2s"
  image_publisher         = "Canonical"
  image_offer             = "UbuntuServer"
  image_sku               = "18.04-LTS"
  image_version           = "latest"
}

module "action_group" {
  source                  = "../../modules/action_group"
  resource_group_name     = module.resource_group.name
  name                    = var.act_group_name
  email_receivers         = var.email_receivers
  sms_receivers           = var.sms_receiver
}

module "alert_rule" {
  source                  = "../../modules/alert_rule"
  resource_group_name     = module.resource_group.name
  name                    = "my-alert-rule"
  target_resource_id      = module.virtual_machine.virtual_machine_id
  action_group_id         = module.action_group.action_group_id
  condition_metric        = "Percentage CPU"
  condition_operator      = "GreaterThan"
  condition_threshold     = 90
}