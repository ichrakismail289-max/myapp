terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"  # ou la dernière version stable
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://192.168.17.134:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = var.proxmox_password
  pm_tls_insecure = true
}
