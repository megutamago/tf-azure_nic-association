##### Linux OS #####
resource "azurerm_virtual_machine" "vm" {
  name                             = local.vmname
  resource_group_name              = local.resource_group.name
  location                         = local.resource_group.location
  vm_size                          = "Standard_D2s_v3"
  primary_network_interface_id     = local.nicids[0]
  network_interface_ids            = local.nicids
  zones                            = [var.zone]

  storage_image_reference {
    id        = local.image_id
  }

  storage_os_disk {
    name                      = "${local.vmname}_disk1_${random_id.name.hex}"
    create_option             = "FromImage"
    caching                   = "ReadWrite"
    managed_disk_type         = "StandardSSD_LRS"
    write_accelerator_enabled = false
  }

  os_profile {
    computer_name  = "${local.vmname}"
    admin_username = "hogeuser"
    admin_password = "Passw0rd!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

##### Network Interface #####
resource "azurerm_network_interface" "vm" {
  for_each                      = local.subnet
  name                          = "${var.application.name}-nic-${each.key}"
  resource_group_name           = local.resource_group.name
  location                      = local.resource_group.location
  enable_accelerated_networking = var.enable_accelerated_networking

  ip_configuration {
    name                          = "ip1"
    primary                       = true
    subnet_id                     = local.subnet[each.key].id
    private_ip_address_allocation = "Static"
    private_ip_address            = local.ips[each.key]
  }
}

##### Assign NSG #####
resource "azurerm_network_interface_security_group_association" "vm" {
  for_each                  = azurerm_network_interface.vm 
  network_interface_id      = each.value.id
  network_security_group_id = local.network_security_group_id[each.key]
}

##### Assign ASG #####
resource "azurerm_network_interface_application_security_group_association" "vm" {
  for_each                      = azurerm_network_interface.vm 
  network_interface_id          = each.value.id
  application_security_group_id = local.application_security_group_id[each.key]
}
