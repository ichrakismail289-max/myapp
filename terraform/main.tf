provider "proxmox" {
  pm_api_url      = "https://192.168.17.131:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = "ichrak1234"
  pm_tls_insecure = true
}

resource "proxmox_lxc" "ct_base" {
  hostname   = "ct-base"
  target_node = "pve"  # Remplace par ton node
  ostemplate = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.gz"
  password   = "ichrak1234"       # mot de passe root du LXC
  cores      = 2
  memory     = 2048

  rootfs {
    storage = "local-lvm"  # ← Indique ton storage Proxmox
    size    = "8G"
  }

  network {
    name = "eth0"
    bridge = "vmbr0"
    ip = "192.168.100.134/24"
    type = "veth"
    gateway = "192.168.17.134"
  }
}
