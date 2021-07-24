provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  features {}
}

resource "random_string" "name" {
  length  = 4
  special = false
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-${random_string.name.result}"
  address_space       = ["10.240.0.0/16"]
  location            = "Canada Central"
  resource_group_name = "sandbox-cc-rg"
}

resource "azurerm_subnet" "main" {
  name                 = "subnet-${random_string.name.result}"
  resource_group_name  = azurerm_virtual_network.main.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.240.1.0/24"]
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "la-${random_string.name.result}"
  location            = azurerm_virtual_network.main.location
  resource_group_name = azurerm_virtual_network.main.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

module "windows_vmss" {
  source = "../../../../"

  ### General configuration
  environment          = "qa"
  vmss_name            = "win${random_string.name.result}"
  computer_name_prefix = "win${random_string.name.result}"
  resource_group_name  = azurerm_virtual_network.main.resource_group_name
  location             = azurerm_virtual_network.main.location

  ### Network Interfaces
  network_config = [{
    primary                                      = true
    vnet_subnet_id                               = azurerm_subnet.main.id
    dns_servers                                  = []
    enable_ip_forwarding                         = false
    enable_accelerated_networking                = false
    network_security_group_id                    = null
    load_balancer_backend_address_pool_ids       = [azurerm_lb_backend_address_pool.main.id]
    load_balancer_inbound_nat_rules_ids          = [azurerm_lb_nat_pool.main.id]
    application_gateway_backend_address_pool_ids = []
    }
  ]

  ### Virtual machine scale set configuration
  os_flavor             = "windows"
  instances_count       = 1
  additional_data_disks = [100]

  ### Virtual machine using ephemeral disk
  os_disk_caching      = "ReadOnly"
  disk_size_gb         = "1024"
  virtual_machine_size = "Standard_D48s_v3"

  ### Image configuration
  marketplace_image = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  ### Virtual machine auto scaling  configuration
  enable_autoscale_for_vmss          = true
  minimum_instances_count            = 1
  maximum_instances_count            = 5
  scale_out_cpu_percentage_threshold = 80
  scale_in_cpu_percentage_threshold  = 20

  ### Custom extension
  custom_extension = {
    publisher                  = "Microsoft.Compute"
    type                       = "CustomScriptExtension"
    type_handler_version       = "1.9"
    settings                   = { "commandToExecute" : "powershell Install-WindowsFeature -name Web-Server -IncludeManagementTools" }
    protected_settings         = null
    provision_after_extensions = []
  }

  ### Install Log Analytics Agent
  deploy_log_analytics_agent = {
    workspace_id  = azurerm_log_analytics_workspace.main.workspace_id
    workspace_key = azurerm_log_analytics_workspace.main.primary_shared_key
  }

}
