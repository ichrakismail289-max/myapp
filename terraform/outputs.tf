output "lxc_ip" {
  value = proxmox_lxc.ct_base.network[0].ip
}
