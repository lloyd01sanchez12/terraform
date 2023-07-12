resource "azurerm_monitor_metric_alert" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  target_resource_id  = var.target_resource_id

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = var.condition_metric
    aggregation      = "Average"
    operator         = var.condition_operator
    threshold        = var.condition_threshold
  }

  action {
    action_group_id = var.action_group_id
  }
}