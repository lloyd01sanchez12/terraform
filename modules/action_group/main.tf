resource "azurerm_monitor_action_group" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name

  email_receiver {
    name  = "email"
    email = var.email_receivers
  }

  sms_receiver {
    name        = "sms"
    country_code = "+1"
    phone_number = var.sms_receivers
  }
}