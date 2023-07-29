terraform {
  required_version = ">= 1.3.0"

  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.14"
    }

    local = ">= 2.2.3"
    null  = ">= 3.1.1"
  }
}
