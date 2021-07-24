data "azurerm_monitor_diagnostic_categories" "main" {
  resource_id = var.os_flavor == "windows" ? azurerm_windows_virtual_machine_scale_set.main.0.id : azurerm_linux_virtual_machine_scale_set.main.0.id
}

resource "azurerm_monitor_diagnostic_setting" "custom" {
  for_each                       = var.diagnostics != null ? toset(["custom"]) : []
  name                           = "${var.os_flavor == "windows" ? azurerm_windows_virtual_machine_scale_set.main.0.name : azurerm_linux_virtual_machine_scale_set.main.0.name}-custom-diag"
  target_resource_id             = var.os_flavor == "windows" ? azurerm_windows_virtual_machine_scale_set.main.0.id : azurerm_linux_virtual_machine_scale_set.main.0.id
  log_analytics_workspace_id     = local.parsed_diag.log_analytics_id
  eventhub_authorization_rule_id = local.parsed_diag.event_hub_auth_id
  eventhub_name                  = local.parsed_diag.event_hub_auth_id != null ? var.diagnostics.eventhub_name : null
  storage_account_id             = local.parsed_diag.storage_account_id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.main.logs
    content {
      category = log.value
      enabled  = contains(local.parsed_diag.log, "all") || contains(local.parsed_diag.log, log.value)

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.main.metrics
    content {
      category = metric.value
      enabled  = contains(local.parsed_diag.metric, "all") || contains(local.parsed_diag.metric, metric.value)

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }
}
