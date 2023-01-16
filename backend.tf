terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

##### 環境変数 #####
variable "private_ip_address" {}

locals {
  resource_group = {
    name     = "common-rg-east"
    location = "japaneast"
  }

  storage_account = {
    primary_blob_endpoint = var.primary_blob_endpoint
  }

  zone     = "1"
  vmname   = ""
  image_id = ""
  enable_accelerated_networking = false

  # az network vnet subnet list --resource-group common-rg-east --vnet-name common-vnet
  subnet_watch_id = ""
  subnet_service_id = ""

  network_security_group_id     = {
    lan1 = "/subscriptions/${var.subscription}/resourceGroups/common-rg-east/providers/Microsoft.Network/networkSecurityGroups/common-nsg-watch-${var.security_group_number}"
    lan2 = "/subscriptions/${var.subscription}/resourceGroups/common-rg-east/providers/Microsoft.Network/networkSecurityGroups/common-nsg-service-${var.security_group_number}"
  }
  application_security_group_id = {
    lan1 = ""
    lan2 = ""
  }
}
