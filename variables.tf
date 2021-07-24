variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  type        = string
}

variable "location" {
  description = "(Optional) The location in which the resources will be created. Defaults to Canada Central"
  type        = string
  default     = "Canada Central"
}

variable "environment" {
  type        = string
  description = "Which enviroment dev, qa, stage, production"
}

variable "vmss_name" {
  description = "Specifies the name of the virtual machine scale set resource. Prefix vmss- will be applied"
}

variable "computer_name_prefix" {
  description = "Specifies the name prefix of the virtual machine inside the VM scale set"
}

variable "network_config" {
  description = "A list of network interfaces to be applied to each scale set"
  type = list(object({
    primary                                      = bool,
    vnet_subnet_id                               = string,
    dns_servers                                  = list(string),
    enable_ip_forwarding                         = bool,
    enable_accelerated_networking                = bool,
    network_security_group_id                    = string,
    load_balancer_backend_address_pool_ids       = list(string),
    load_balancer_inbound_nat_rules_ids          = list(string),
    application_gateway_backend_address_pool_ids = list(string)
  }))
}

variable "enable_boot_diag" {
  description = "Enable Boot Diagnostic Storage Account"
  type        = bool
  default     = true
}

variable "shared_image" {
  description = "Provide the Shared Image Gallery image info"
  type = object({
    image_name         = string,
    image_gallery_name = string,
    image_gallery_rg   = string,
  })

  default = null
}

variable "marketplace_image" {
  description = "Provide the marketplace image info"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = null
}

variable "os_flavor" {
  type        = string
  default     = "linux"
  description = "Specify the flavour of the operating system image to deploy VMSS. Valid values are `windows` and `linux`"
}

variable "overprovision" {
  description = "Should Azure over-provision Virtual Machines in this Scale Set? This means that multiple Virtual Machines will be provisioned and Azure will keep the instances which become available first - which improves provisioning success rates and improves deployment time. You're not billed for these over-provisioned VM's and they don't count towards the Subscription Quota. Defaults to true."
  default     = false
}

variable "virtual_machine_size" {
  description = "The Virtual Machine SKU for the Scale Set, Default is Standard_A2_V2"
  default     = "Standard_D2s_v3"
}

variable "instances_count" {
  description = "The number of Virtual Machines in the Scale Set."
  default     = 1
}

variable "availability_zones" {
  description = "A list of Availability Zones in which the Virtual Machines in this Scale Set should be created in"
  default     = [1, 2, 3]
}

variable "availability_zone_balance" {
  description = "Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones?"
  default     = true
}

variable "single_placement_group" {
  description = "Allow to have cluster of 100 VMs only"
  default     = true
}

variable "os_upgrade_mode" {
  description = "Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling. Defaults to Manual"
  default     = "Manual"
}

variable "os_disk_storage_account_type" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values include Standard_LRS, StandardSSD_LRS and Premium_LRS."
  default     = "Standard_LRS"
}

variable "additional_data_disks" {
  description = "Adding additional disks capacity to add each instance (GB)"
  type        = list(number)
  default     = []
}

variable "additional_data_disks_storage_account_type" {
  description = "The Type of Storage Account which should back this Data Disk. Possible values include Standard_LRS, StandardSSD_LRS, Premium_LRS and UltraSSD_LRS."
  default     = "Premium_LRS"
  type        = string
}

variable "enable_automatic_instance_repair" {
  type        = string
  description = "Should the automatic instance repair be enabled on this Virtual Machine Scale Set?"
  default     = false
}

variable "grace_period" {
  type        = string
  description = "Amount of time (in minutes, between 30 and 90, defaults to 30 minutes) for which automatic repairs will be delayed."
  default     = "PT30M"
}

variable "enable_autoscale_for_vmss" {
  description = "Manages a AutoScale Setting which can be applied to Virtual Machine Scale Sets"
  default     = false
}

variable "minimum_instances_count" {
  description = "The minimum number of instances for this resource. Valid values are between 0 and 1000"
  default     = null
}

variable "maximum_instances_count" {
  description = "The maximum number of instances for this resource. Valid values are between 0 and 1000"
  default     = ""
}

variable "max_batch_instance_percent" {
  type        = number
  default     = 20
  description = "The maximum percent of total virtual machine instances that will be upgraded simultaneously by the rolling upgrade in one batch. As this is a maximum, unhealthy instances in previous or future batches can cause the percentage of instances in a batch to decrease to ensure higher reliability. Changing this forces a new resource to be created"
}
variable "max_unhealthy_instance_percent" {
  type        = number
  default     = 20
  description = "The maximum percentage of the total virtual machine instances in the scale set that can be simultaneously unhealthy, either as a result of being upgraded, or by being found in an unhealthy state by the virtual machine health checks before the rolling upgrade aborts. This constraint will be checked prior to starting any batch. Changing this forces a new resource to be created."
}
variable "max_unhealthy_upgraded_instance_percent" {
  type        = number
  default     = 20
  description = "The maximum percentage of upgraded virtual machine instances that can be found to be in an unhealthy state. This check will happen after each batch is upgraded. If this percentage is ever exceeded, the rolling update aborts. Changing this forces a new resource to be created."
}
variable "pause_time_between_batches" {
  type        = string
  default     = "PT0S"
  description = "The wait time between completing the update for all virtual machines in one batch and starting the next batch. The time duration should be specified in ISO 8601 format. Changing this forces a new resource to be created"
}

variable "disable_automatic_rollback" {
  default     = true
  type        = bool
  description = "Should automatic rollbacks be disabled"
}

variable "enable_automatic_os_upgrade" {
  default     = true
  type        = bool
  description = "Should OS Upgrades automatically be applied to Scale Set instances in a rolling fashion when a newer version of the OS Image becomes available"
}

variable "os_disk_caching" {
  default     = "ReadOnly"
  type        = string
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite"
}

variable "ultra_ssd_enabled" {
  type        = string
  default     = "false"
  description = "Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine Scale Set? Defaults to false"
}

variable "data_disk_caching" {
  type        = string
  default     = "ReadWrite"
  description = "The type of Caching which should be used for this Data Disk"
}

variable "data_disk_create_option" {
  type        = string
  default     = "Empty"
  description = "The create option which should be used for this Data Disk. Possible values are Empty and FromImage. Defaults to Empty. (FromImage should only be used if the source image includes data disks)."
}

variable "write_accelerator_enabled" {
  type        = bool
  default     = false
  description = "Should Write Accelerator be enabled for this Data Disk?"
}

variable "do_not_run_extensions_on_overprovisioned_machines" {
  type        = bool
  default     = false
  description = "Should Virtual Machine Extensions be run on Overprovisioned Virtual Machines in the Scale Set?"
}

variable "encryption_at_host_enabled" {
  type        = bool
  default     = false
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
}

variable "priority" {
  type        = string
  default     = "Regular"
  description = "The Priority of this Virtual Machine Scale Set. Possible values are Regular and Spot"
}

variable "provision_vm_agent" {
  type        = bool
  default     = true
  description = "Should the Azure VM Agent be provisioned on each Virtual Machine in the Scale Set? "
}

variable "scale_in_policy" {
  type        = string
  default     = "Default"
  description = "The scale-in policy rule that decides which virtual machines are chosen for removal when a Virtual Machine Scale Set is scaled in. Possible values for the scale-in policy rules are Default, NewestVM and OldestVM, defaults to Default"
}

variable "disk_size_gb" {
  type        = number
  default     = null
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine Scale Set is sourced from."
}

variable "diff_disk_settings" {
  type        = bool
  default     = false
  description = "Enables the diff disk setting. Currently only Local is supported"
}

variable "generate_admin_ssh_key" {
  description = "Generates a secure private key and encodes it as PEM."
  default     = true
}

variable "diagnostics" {
  description = "Diagnostic settings for those resources that support it."
  type = object({
    destination   = string
    eventhub_name = string
    logs          = list(string)
    metrics       = list(string)
  })
  default = null
}

variable "deploy_log_analytics_agent" {
  description = "Provide the workspace ID and the workspace Key to install the log analytics agent."
  type = object({
    workspace_id  = string
    workspace_key = string
  })
  default = null
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "scale_out_cpu_percentage_threshold" {
  description = "Specifies the threshold % of the metric that triggers the scale out action."
  default     = "80"
}

variable "scale_in_cpu_percentage_threshold" {
  description = "Specifies the threshold of the metric that triggers the scale in action."
  default     = "20"
}

variable "scaling_action_instances_number" {
  description = "The number of instances involved in the scaling action"
  default     = "1"
}

variable "admin_ssh_key_data" {
  description = "specify the path to the existing ssh key to authenciate linux vm if generate ssh key is set to false"
  default     = ""
}

variable "admin_username" {
  description = "Specify a prefered Admin Username. If not specified a random username will be created"
  default     = null
  type        = string
}

variable "health_probe_id" {
  description = "The ID of a Load Balancer Probe which should be used to determine the health of an instance. This is Required and can only be specified when upgrade_mode is set to Automatic or Rolling."
  default     = null
}

variable "enable_health_extension" {
  description = "Enable the Application Health extension on the VMSS scale set. Only Linux Currently Supported"
  type        = bool
  default     = false
}

variable "custom_data" {
  description = "The Base64-Encoded Custom Data which should be used for this Virtual Machine Scale Set."
  type        = string
  default     = null
}

variable "custom_extension" {
  description = "A custom extension block see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension"
  type = object({
    publisher                  = string
    type                       = string
    type_handler_version       = string
    settings                   = map(any)
    protected_settings         = map(any)
    provision_after_extensions = list(string)
  })
  default = null
}