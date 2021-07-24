## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.60.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.auto](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_diagnostic_setting.custom](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_storage_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_virtual_machine_scale_set_extension.custom](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension) | resource |
| [azurerm_virtual_machine_scale_set_extension.linux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension) | resource |
| [azurerm_virtual_machine_scale_set_extension.omsagentlinux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension) | resource |
| [azurerm_virtual_machine_scale_set_extension.omsagentwin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension) | resource |
| [azurerm_windows_virtual_machine_scale_set.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine_scale_set) | resource |
| [random_password.passwd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.primary](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.username](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [tls_private_key.key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_monitor_diagnostic_categories.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_shared_image.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/shared_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_data_disks"></a> [additional\_data\_disks](#input\_additional\_data\_disks) | Adding additional disks capacity to add each instance (GB) | `list(number)` | `[]` | no |
| <a name="input_additional_data_disks_storage_account_type"></a> [additional\_data\_disks\_storage\_account\_type](#input\_additional\_data\_disks\_storage\_account\_type) | The Type of Storage Account which should back this Data Disk. Possible values include Standard\_LRS, StandardSSD\_LRS, Premium\_LRS and UltraSSD\_LRS. | `string` | `"Premium_LRS"` | no |
| <a name="input_admin_ssh_key_data"></a> [admin\_ssh\_key\_data](#input\_admin\_ssh\_key\_data) | specify the path to the existing ssh key to authenciate linux vm if generate ssh key is set to false | `string` | `""` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Specify a prefered Admin Username. If not specified a random username will be created | `string` | `null` | no |
| <a name="input_availability_zone_balance"></a> [availability\_zone\_balance](#input\_availability\_zone\_balance) | Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones? | `bool` | `true` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | A list of Availability Zones in which the Virtual Machines in this Scale Set should be created in | `list` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| <a name="input_computer_name_prefix"></a> [computer\_name\_prefix](#input\_computer\_name\_prefix) | Specifies the name prefix of the virtual machine inside the VM scale set | `any` | n/a | yes |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | The Base64-Encoded Custom Data which should be used for this Virtual Machine Scale Set. | `string` | `null` | no |
| <a name="input_custom_extension"></a> [custom\_extension](#input\_custom\_extension) | A custom extension block see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension | <pre>object({<br>    publisher                  = string<br>    type                       = string<br>    type_handler_version       = string<br>    settings                   = map(any)<br>    protected_settings         = map(any)<br>    provision_after_extensions = list(string)<br>  })</pre> | `null` | no |
| <a name="input_data_disk_caching"></a> [data\_disk\_caching](#input\_data\_disk\_caching) | The type of Caching which should be used for this Data Disk | `string` | `"ReadWrite"` | no |
| <a name="input_data_disk_create_option"></a> [data\_disk\_create\_option](#input\_data\_disk\_create\_option) | The create option which should be used for this Data Disk. Possible values are Empty and FromImage. Defaults to Empty. (FromImage should only be used if the source image includes data disks). | `string` | `"Empty"` | no |
| <a name="input_deploy_log_analytics_agent"></a> [deploy\_log\_analytics\_agent](#input\_deploy\_log\_analytics\_agent) | Provide the workspace ID and the workspace Key to install the log analytics agent. | <pre>object({<br>    workspace_id  = string<br>    workspace_key = string<br>  })</pre> | `null` | no |
| <a name="input_diagnostics"></a> [diagnostics](#input\_diagnostics) | Diagnostic settings for those resources that support it. | <pre>object({<br>    destination   = string<br>    eventhub_name = string<br>    logs          = list(string)<br>    metrics       = list(string)<br>  })</pre> | `null` | no |
| <a name="input_diff_disk_settings"></a> [diff\_disk\_settings](#input\_diff\_disk\_settings) | Enables the diff disk setting. Currently only Local is supported | `bool` | `false` | no |
| <a name="input_disable_automatic_rollback"></a> [disable\_automatic\_rollback](#input\_disable\_automatic\_rollback) | Should automatic rollbacks be disabled | `bool` | `true` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine Scale Set is sourced from. | `number` | `null` | no |
| <a name="input_do_not_run_extensions_on_overprovisioned_machines"></a> [do\_not\_run\_extensions\_on\_overprovisioned\_machines](#input\_do\_not\_run\_extensions\_on\_overprovisioned\_machines) | Should Virtual Machine Extensions be run on Overprovisioned Virtual Machines in the Scale Set? | `bool` | `false` | no |
| <a name="input_enable_automatic_instance_repair"></a> [enable\_automatic\_instance\_repair](#input\_enable\_automatic\_instance\_repair) | Should the automatic instance repair be enabled on this Virtual Machine Scale Set? | `string` | `false` | no |
| <a name="input_enable_automatic_os_upgrade"></a> [enable\_automatic\_os\_upgrade](#input\_enable\_automatic\_os\_upgrade) | Should OS Upgrades automatically be applied to Scale Set instances in a rolling fashion when a newer version of the OS Image becomes available | `bool` | `true` | no |
| <a name="input_enable_autoscale_for_vmss"></a> [enable\_autoscale\_for\_vmss](#input\_enable\_autoscale\_for\_vmss) | Manages a AutoScale Setting which can be applied to Virtual Machine Scale Sets | `bool` | `false` | no |
| <a name="input_enable_boot_diag"></a> [enable\_boot\_diag](#input\_enable\_boot\_diag) | Enable Boot Diagnostic Storage Account | `bool` | `true` | no |
| <a name="input_enable_health_extension"></a> [enable\_health\_extension](#input\_enable\_health\_extension) | Enable the Application Health extension on the VMSS scale set. Only Linux Currently Supported | `bool` | `false` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host? | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Which enviroment dev, qa, stage, production | `string` | n/a | yes |
| <a name="input_generate_admin_ssh_key"></a> [generate\_admin\_ssh\_key](#input\_generate\_admin\_ssh\_key) | Generates a secure private key and encodes it as PEM. | `bool` | `true` | no |
| <a name="input_grace_period"></a> [grace\_period](#input\_grace\_period) | Amount of time (in minutes, between 30 and 90, defaults to 30 minutes) for which automatic repairs will be delayed. | `string` | `"PT30M"` | no |
| <a name="input_health_probe_id"></a> [health\_probe\_id](#input\_health\_probe\_id) | The ID of a Load Balancer Probe which should be used to determine the health of an instance. This is Required and can only be specified when upgrade\_mode is set to Automatic or Rolling. | `any` | `null` | no |
| <a name="input_instances_count"></a> [instances\_count](#input\_instances\_count) | The number of Virtual Machines in the Scale Set. | `number` | `1` | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional) The location in which the resources will be created. Defaults to Canada Central | `string` | `"Canada Central"` | no |
| <a name="input_marketplace_image"></a> [marketplace\_image](#input\_marketplace\_image) | Provide the marketplace image info | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | `null` | no |
| <a name="input_max_batch_instance_percent"></a> [max\_batch\_instance\_percent](#input\_max\_batch\_instance\_percent) | The maximum percent of total virtual machine instances that will be upgraded simultaneously by the rolling upgrade in one batch. As this is a maximum, unhealthy instances in previous or future batches can cause the percentage of instances in a batch to decrease to ensure higher reliability. Changing this forces a new resource to be created | `number` | `20` | no |
| <a name="input_max_unhealthy_instance_percent"></a> [max\_unhealthy\_instance\_percent](#input\_max\_unhealthy\_instance\_percent) | The maximum percentage of the total virtual machine instances in the scale set that can be simultaneously unhealthy, either as a result of being upgraded, or by being found in an unhealthy state by the virtual machine health checks before the rolling upgrade aborts. This constraint will be checked prior to starting any batch. Changing this forces a new resource to be created. | `number` | `20` | no |
| <a name="input_max_unhealthy_upgraded_instance_percent"></a> [max\_unhealthy\_upgraded\_instance\_percent](#input\_max\_unhealthy\_upgraded\_instance\_percent) | The maximum percentage of upgraded virtual machine instances that can be found to be in an unhealthy state. This check will happen after each batch is upgraded. If this percentage is ever exceeded, the rolling update aborts. Changing this forces a new resource to be created. | `number` | `20` | no |
| <a name="input_maximum_instances_count"></a> [maximum\_instances\_count](#input\_maximum\_instances\_count) | The maximum number of instances for this resource. Valid values are between 0 and 1000 | `string` | `""` | no |
| <a name="input_minimum_instances_count"></a> [minimum\_instances\_count](#input\_minimum\_instances\_count) | The minimum number of instances for this resource. Valid values are between 0 and 1000 | `any` | `null` | no |
| <a name="input_network_config"></a> [network\_config](#input\_network\_config) | A list of network interfaces to be applied to each scale set | <pre>list(object({<br>    primary                                      = bool,<br>    vnet_subnet_id                               = string,<br>    dns_servers                                  = list(string),<br>    enable_ip_forwarding                         = bool,<br>    enable_accelerated_networking                = bool,<br>    network_security_group_id                    = string,<br>    load_balancer_backend_address_pool_ids       = list(string),<br>    load_balancer_inbound_nat_rules_ids          = list(string),<br>    application_gateway_backend_address_pool_ids = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite | `string` | `"ReadOnly"` | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values include Standard\_LRS, StandardSSD\_LRS and Premium\_LRS. | `string` | `"Standard_LRS"` | no |
| <a name="input_os_flavor"></a> [os\_flavor](#input\_os\_flavor) | Specify the flavour of the operating system image to deploy VMSS. Valid values are `windows` and `linux` | `string` | `"linux"` | no |
| <a name="input_os_upgrade_mode"></a> [os\_upgrade\_mode](#input\_os\_upgrade\_mode) | Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling. Defaults to Manual | `string` | `"Manual"` | no |
| <a name="input_overprovision"></a> [overprovision](#input\_overprovision) | Should Azure over-provision Virtual Machines in this Scale Set? This means that multiple Virtual Machines will be provisioned and Azure will keep the instances which become available first - which improves provisioning success rates and improves deployment time. You're not billed for these over-provisioned VM's and they don't count towards the Subscription Quota. Defaults to true. | `bool` | `false` | no |
| <a name="input_pause_time_between_batches"></a> [pause\_time\_between\_batches](#input\_pause\_time\_between\_batches) | The wait time between completing the update for all virtual machines in one batch and starting the next batch. The time duration should be specified in ISO 8601 format. Changing this forces a new resource to be created | `string` | `"PT0S"` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | The Priority of this Virtual Machine Scale Set. Possible values are Regular and Spot | `string` | `"Regular"` | no |
| <a name="input_provision_vm_agent"></a> [provision\_vm\_agent](#input\_provision\_vm\_agent) | Should the Azure VM Agent be provisioned on each Virtual Machine in the Scale Set? | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resources will be created. | `string` | n/a | yes |
| <a name="input_scale_in_cpu_percentage_threshold"></a> [scale\_in\_cpu\_percentage\_threshold](#input\_scale\_in\_cpu\_percentage\_threshold) | Specifies the threshold of the metric that triggers the scale in action. | `string` | `"20"` | no |
| <a name="input_scale_in_policy"></a> [scale\_in\_policy](#input\_scale\_in\_policy) | The scale-in policy rule that decides which virtual machines are chosen for removal when a Virtual Machine Scale Set is scaled in. Possible values for the scale-in policy rules are Default, NewestVM and OldestVM, defaults to Default | `string` | `"Default"` | no |
| <a name="input_scale_out_cpu_percentage_threshold"></a> [scale\_out\_cpu\_percentage\_threshold](#input\_scale\_out\_cpu\_percentage\_threshold) | Specifies the threshold % of the metric that triggers the scale out action. | `string` | `"80"` | no |
| <a name="input_scaling_action_instances_number"></a> [scaling\_action\_instances\_number](#input\_scaling\_action\_instances\_number) | The number of instances involved in the scaling action | `string` | `"1"` | no |
| <a name="input_shared_image"></a> [shared\_image](#input\_shared\_image) | Provide the Shared Image Gallery image info | <pre>object({<br>    image_name         = string,<br>    image_gallery_name = string,<br>    image_gallery_rg   = string,<br>  })</pre> | `null` | no |
| <a name="input_single_placement_group"></a> [single\_placement\_group](#input\_single\_placement\_group) | Allow to have cluster of 100 VMs only | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources created. | `map(string)` | `{}` | no |
| <a name="input_ultra_ssd_enabled"></a> [ultra\_ssd\_enabled](#input\_ultra\_ssd\_enabled) | Should the capacity to enable Data Disks of the UltraSSD\_LRS storage account type be supported on this Virtual Machine Scale Set? Defaults to false | `string` | `"false"` | no |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | The Virtual Machine SKU for the Scale Set, Default is Standard\_A2\_V2 | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_vmss_name"></a> [vmss\_name](#input\_vmss\_name) | Specifies the name of the virtual machine scale set resource. Prefix vmss- will be applied | `any` | n/a | yes |
| <a name="input_write_accelerator_enabled"></a> [write\_accelerator\_enabled](#input\_write\_accelerator\_enabled) | Should Write Accelerator be enabled for this Data Disk? | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vmss_linux_id"></a> [vmss\_linux\_id](#output\_vmss\_linux\_id) | The ID of the Linux Virtual Machine Scale Set. |
| <a name="output_vmss_linux_identity"></a> [vmss\_linux\_identity](#output\_vmss\_linux\_identity) | The ID of the System Managed Service Principal. |
| <a name="output_vmss_windows_id"></a> [vmss\_windows\_id](#output\_vmss\_windows\_id) | The ID of the Linux Virtual Machine Scale Set. |
| <a name="output_vmss_windows_identity"></a> [vmss\_windows\_identity](#output\_vmss\_windows\_identity) | The ID of the System Managed Service Principal. |
