output "vmss_linux_id" {
  value       = try(azurerm_linux_virtual_machine_scale_set.main[0].id, null)
  description = "The ID of the Linux Virtual Machine Scale Set."
}

output "vmss_linux_identity" {
  value       = try(azurerm_linux_virtual_machine_scale_set.main[0].identity[0].principal_id, null)
  description = "The ID of the System Managed Service Principal."
}

output "vmss_windows_id" {
  value       = try(azurerm_windows_virtual_machine_scale_set.main[0].id, null)
  description = "The ID of the Linux Virtual Machine Scale Set."
}

output "vmss_windows_identity" {
  value       = try(azurerm_windows_virtual_machine_scale_set.main[0].identity[0].principal_id, null)
  description = "The ID of the System Managed Service Principal."
}