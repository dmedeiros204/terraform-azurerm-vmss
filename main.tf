resource "random_string" "primary" {
  length  = 3
  special = false
  keepers = {
    instance_id = var.os_flavor
  }
}

resource "azurerm_storage_account" "main" {
  name                     = "stdiag${lower(replace(var.vmss_name, "/[[:^alnum:]]/", ""))}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "tls_private_key" "key" {
  count     = var.generate_admin_ssh_key == true && lower(var.os_flavor) == "linux" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_password" "passwd" {
  count       = lower(var.os_flavor) == "windows" ? 1 : 0
  length      = 8
  min_upper   = 2
  min_lower   = 2
  min_numeric = 1
  special     = false

  keepers = {
    admin_password = var.os_flavor
  }
}

resource "random_string" "username" {
  count   = var.admin_username == null ? 1 : 0
  length  = 6
  special = false
}

data "azurerm_shared_image" "main" {
  count               = var.shared_image == null ? 0 : 1
  name                = var.shared_image.image_name
  gallery_name        = var.shared_image.image_gallery_name
  resource_group_name = var.shared_image.image_gallery_rg
}
