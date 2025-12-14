terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.7"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://192.168.17.134:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = "TON_MOT_DE_PASSE"
  pm_tls_insecure = true
}

resource "proxmox_lxc" "ct_base" {
  hostname    = "ct-base"
  target_node = "ct-base"  # <-- le node de ton Proxmox
  ostemplate  = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.gz"
  memory      = 2048
  cores       = 2

  rootfs {
    size = "10G"
  }

  network {
    name    = "eth0"
    bridge  = "vmbr0"
    ip      = "dhcp"
  }
}
