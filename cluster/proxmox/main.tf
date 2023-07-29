resource "proxmox_vm_qemu" "master" {
  count             = var.master_node_count
  name              = format("%s-m%d", var.cluster_name, count.index)
  target_node       = var.pm_target_node
  clone             = var.pm_vm_template
  full_clone        = true
  cpu               = "host"
  cores             = var.master_cpu_count
  sockets           = 1
  memory            = var.master_node_memory
  network {
    bridge            = var.pm_network
    model             = "virtio"
    firewall          = false
  }
  agent             = 1
  os_type           = "cloud-init"
  cicustom          = "user=local:snippets/user_data_${var.cluster_name}_m${count.index}.yml"
  cloudinit_cdrom_storage = var.pm_cdrom_storage
  scsihw           = "virtio-scsi-single"
  disk {
    storage           = var.pm_disk_storage
    size              = "50G"
    type              = "scsi"
    iothread          = 0
  }

  lifecycle {
    ignore_changes = [
      network,
      ipconfig0,
      qemu_os,
      disk
    ]
  }
}

resource "proxmox_vm_qemu" "worker" {
  depends_on        = [ resource.proxmox_vm_qemu.master ]
  count             = var.worker_node_count
  name              = format("%s-w%d", var.cluster_name, count.index)
  target_node       = var.pm_target_node
  clone             = var.pm_vm_template
  full_clone        = true
  cpu               = "host"
  cores             = var.worker_cpu_count
  sockets           = 1
  memory            = var.worker_node_memory
  network {
    bridge            = var.pm_network
    model             = "virtio"
    firewall          = false
  }
  agent             = 1
  os_type           = "cloud-init"
  cicustom          = "user=local:snippets/user_data_${var.cluster_name}_w${count.index}.yml"
  cloudinit_cdrom_storage = var.pm_cdrom_storage
  scsihw           = "virtio-scsi-single"
  disk {
    storage           = var.pm_disk_storage
    size              = "50G"
    type              = "scsi"
    iothread          = 0
  }

  lifecycle {
    ignore_changes = [
      network,
      ipconfig0,
      qemu_os,
      disk
    ]
  }
}

output "master" {
  value = proxmox_vm_qemu.master
}

output "worker" {
  value = proxmox_vm_qemu.worker
}
