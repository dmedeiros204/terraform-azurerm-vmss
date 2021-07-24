resource "azurerm_windows_virtual_machine_scale_set" "main" {
  count                                             = lower(var.os_flavor) == "windows" ? 1 : 0
  name                                              = format("vmss-%s-%s", lower(var.vmss_name), lower(var.environment))
  location                                          = var.location
  resource_group_name                               = var.resource_group_name
  admin_username                                    = var.admin_username == null ? random_string.username[0].result : var.admin_username
  computer_name_prefix                              = var.computer_name_prefix
  admin_password                                    = random_password.passwd[0].result
  instances                                         = var.instances_count
  sku                                               = var.virtual_machine_size
  do_not_run_extensions_on_overprovisioned_machines = var.do_not_run_extensions_on_overprovisioned_machines
  encryption_at_host_enabled                        = var.encryption_at_host_enabled
  health_probe_id                                   = var.health_probe_id
  custom_data                                       = var.custom_data
  overprovision                                     = var.overprovision
  priority                                          = var.priority
  provision_vm_agent                                = var.provision_vm_agent
  scale_in_policy                                   = var.scale_in_policy
  single_placement_group                            = var.single_placement_group
  source_image_id                                   = try(data.azurerm_shared_image.main[0].id, null)
  upgrade_mode                                      = var.os_upgrade_mode
  zone_balance                                      = var.availability_zone_balance
  zones                                             = var.availability_zones

  dynamic "source_image_reference" {
    for_each = try(data.azurerm_shared_image.main[0].id, null) != null ? [] : ["marketplace_image"]
    content {
      publisher = var.marketplace_image.publisher
      offer     = var.marketplace_image.offer
      sku       = var.marketplace_image.sku
      version   = var.marketplace_image.version
    }
  }

  dynamic "network_interface" {
    for_each = { for network, networks in var.network_config : network => networks }
    content {
      name                          = lower("nic-${format("%s%s", lower(replace(var.vmss_name, "/[[:^alnum:]]/", "")), network_interface.key)}")
      primary                       = network_interface.value.primary
      dns_servers                   = network_interface.value.dns_servers
      enable_ip_forwarding          = network_interface.value.enable_ip_forwarding
      enable_accelerated_networking = network_interface.value.enable_accelerated_networking

      ip_configuration {
        name                                         = lower("ipconig-${format("%s%s", lower(replace(var.vmss_name, "/[[:^alnum:]]/", "")), network_interface.key)}")
        primary                                      = network_interface.value.primary
        subnet_id                                    = network_interface.value.vnet_subnet_id
        load_balancer_backend_address_pool_ids       = network_interface.value.load_balancer_backend_address_pool_ids
        load_balancer_inbound_nat_rules_ids          = network_interface.value.load_balancer_inbound_nat_rules_ids
        application_gateway_backend_address_pool_ids = network_interface.value.application_gateway_backend_address_pool_ids
      }
    }
  }

  os_disk {
    storage_account_type = var.os_disk_storage_account_type
    caching              = var.os_disk_caching
    disk_size_gb         = var.disk_size_gb


    dynamic "diff_disk_settings" {
      for_each = var.diff_disk_settings ? ["enabled"] : []
      content {
        option = "Local"
      }
    }
  }

  additional_capabilities {
    ultra_ssd_enabled = var.ultra_ssd_enabled
  }

  dynamic "automatic_os_upgrade_policy" {
    for_each = var.os_upgrade_mode == "Automatic" ? [1] : []
    content {
      disable_automatic_rollback  = var.disable_automatic_rollback
      enable_automatic_os_upgrade = var.enable_automatic_os_upgrade
    }
  }

  dynamic "automatic_instance_repair" {
    for_each = var.os_upgrade_mode == "Manual" ? [] : [1]
    content {
      enabled      = var.enable_automatic_instance_repair
      grace_period = var.grace_period
    }
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.main.primary_blob_endpoint
  }

  dynamic "data_disk" {
    for_each = var.additional_data_disks
    content {
      caching                   = var.data_disk_caching
      create_option             = var.data_disk_create_option
      disk_size_gb              = data_disk.value
      lun                       = data_disk.key
      storage_account_type      = var.additional_data_disks_storage_account_type
      write_accelerator_enabled = var.write_accelerator_enabled
    }
  }

  identity {
    type = "SystemAssigned"
  }

  dynamic "rolling_upgrade_policy" {
    for_each = var.os_upgrade_mode == "Manual" ? [] : [1]
    content {
      max_batch_instance_percent              = var.max_batch_instance_percent
      max_unhealthy_instance_percent          = var.max_unhealthy_instance_percent
      max_unhealthy_upgraded_instance_percent = var.max_unhealthy_upgraded_instance_percent
      pause_time_between_batches              = var.pause_time_between_batches
    }
  }

  tags = merge(local.default_tags, var.tags)

  lifecycle {
    ignore_changes = [instances]
  }

}