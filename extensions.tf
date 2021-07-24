resource "azurerm_virtual_machine_scale_set_extension" "linux" {
  count                        = lower(var.os_flavor) == "linux" && var.enable_health_extension ? 1 : 0
  name                         = format("%s-health-ext", var.vmss_name)
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.main[0].id
  publisher                    = "Microsoft.ManagedServices"
  type                         = "ApplicationHealthLinux"
  auto_upgrade_minor_version   = true
  type_handler_version         = "1.0"
  settings = jsonencode({
    "protocol" : "http",
    "port" : 80,
    "requestPath" : "/_health_check"
  })
  depends_on = [azurerm_linux_virtual_machine_scale_set.main]
}


resource "azurerm_virtual_machine_scale_set_extension" "custom" {
  count                        = var.custom_extension != null ? 1 : 0
  name                         = format("%s-custom-ext", var.vmss_name)
  virtual_machine_scale_set_id = lower(var.os_flavor) == "windows" ? azurerm_windows_virtual_machine_scale_set.main.0.id : azurerm_linux_virtual_machine_scale_set.main.0.id
  publisher                    = var.custom_extension.publisher
  type                         = var.custom_extension.type
  auto_upgrade_minor_version   = true
  type_handler_version         = var.custom_extension.type_handler_version
  settings                     = try(jsonencode(var.custom_extension.settings), var.custom_extension.settings)
  protected_settings           = try(jsonencode(var.custom_extension.protected_settings), var.custom_extension.protected_settings)
  provision_after_extensions   = var.custom_extension.provision_after_extensions == null ? [] : var.custom_extension.provision_after_extensions
}


resource "azurerm_virtual_machine_scale_set_extension" "omsagentwin" {
  count                        = var.deploy_log_analytics_agent != null && var.os_flavor == "windows" ? 1 : 0
  name                         = "OmsAgentForWindows"
  publisher                    = "Microsoft.EnterpriseCloud.Monitoring"
  type                         = "MicrosoftMonitoringAgent"
  type_handler_version         = "1.0"
  auto_upgrade_minor_version   = true
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.main.0.id

  settings = <<SETTINGS
    {
      "workspaceId": "${var.deploy_log_analytics_agent.workspace_id}"
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
    "workspaceKey": "${var.deploy_log_analytics_agent.workspace_key}"
    }
  PROTECTED_SETTINGS
  depends_on         = [azurerm_windows_virtual_machine_scale_set.main]
}


resource "azurerm_virtual_machine_scale_set_extension" "omsagentlinux" {
  count                        = var.deploy_log_analytics_agent != null && var.os_flavor == "linux" ? 1 : 0
  name                         = "OmsAgentForLinux"
  publisher                    = "Microsoft.EnterpriseCloud.Monitoring"
  type                         = "OmsAgentForLinux"
  type_handler_version         = "1.13"
  auto_upgrade_minor_version   = true
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.main.0.id

  settings = <<SETTINGS
    {
      "workspaceId": "${var.deploy_log_analytics_agent.workspace_id}"
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
    "workspaceKey": "${var.deploy_log_analytics_agent.workspace_key}"
    }
  PROTECTED_SETTINGS
  depends_on         = [azurerm_linux_virtual_machine_scale_set.main]
}