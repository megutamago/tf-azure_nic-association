# tf-azure_nic-association
 Assign NIC to VM : memo

### nic association でのハマりポイントを述べる

```
・ハマりポイント

1. [vm.tf] L7, L8
  primary_network_interface_id     = local.nicids[0]
  network_interface_ids            = local.nicids
  ※リスト構造の変数使うことで、NICを２つ割りてた。

2. [vm.tf] L34 ～ L49
  ※azurerm_network_interface内での each.key を上手く使う。

```
