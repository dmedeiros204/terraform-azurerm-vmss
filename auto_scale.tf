resource "azurerm_monitor_autoscale_setting" "auto" {
  count               = var.enable_autoscale_for_vmss ? 1 : 0
  name                = var.os_flavor == "windows" ? lower("auto-scale-set-${azurerm_windows_virtual_machine_scale_set.main[0].name}") : lower("auto-scale-set-${azurerm_linux_virtual_machine_scale_set.main[0].name}")
  location            = var.location
  resource_group_name = var.resource_group_name
  target_resource_id  = var.os_flavor == "windows" ? azurerm_windows_virtual_machine_scale_set.main.0.id : azurerm_linux_virtual_machine_scale_set.main.0.id

  profile {
    name = "default"
    capacity {
      default = var.instances_count
      minimum = var.minimum_instances_count == null ? var.instances_count : var.minimum_instances_count
      maximum = var.maximum_instances_count
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.os_flavor == "windows" ? azurerm_windows_virtual_machine_scale_set.main.0.id : azurerm_linux_virtual_machine_scale_set.main.0.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = var.scale_out_cpu_percentage_threshold
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = var.scaling_action_instances_number
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.os_flavor == "windows" ? azurerm_windows_virtual_machine_scale_set.main.0.id : azurerm_linux_virtual_machine_scale_set.main.0.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.scale_in_cpu_percentage_threshold
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = var.scaling_action_instances_number
        cooldown  = "PT1M"
      }
    }
  }

  tags = merge(local.default_tags, var.tags)

}
