locals {
  subnet = {
    lan1 = {
      id                   = local.subnet_watch_id
      address_prefixes     = ["172.19.1.0/24"]
    },
    lan2 = {
      id                   = local.subnet_service_id
      address_prefixes     = ["172.19.2.0/24"]
    }
  }

  nicids = [
    azurerm_network_interface.vm["lan1"].id,
    azurerm_network_interface.vm["lan2"].id
  ]

  ips = {
    watch   = "172.19.1.11"
    service = "172.19.2.11"
  }
}
