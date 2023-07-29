variable "nfs_server_path" {
  type    = string
  default = "192.168.40.2:/opt/nfs_shared_folder"
}

variable "pm_network" {
  type    = string
  default = "vmbr1"
}

variable "pm_cdrom_storage" {
  type    = string
  default = "local-zfs"
}

variable "pm_disk_storage" {
  type    = string
  default = "lvm2"
}

variable "ssh_public_key_file" {
  type    = string
  default = "/home/mwiget/.ssh/id_ed25519.pub"
}

variable "master_node_count" {
  type    = number
  default = 1     # only 1 supported for now
}

variable "worker_node_count" {
  type    = number
  default = 3
}

variable "master_cpu_count" {
  type    = number
  default = 2
}

variable "worker_cpu_count" {
  type    = number
  default = 4
}

variable "master_node_memory" {
  type    = number
  default = 4096
}

variable "worker_node_memory" {
  type    = number
  default = 16384
}

variable "pm_vm_template" {
  type    = string
  default = "ubuntu-2204-template"
}

variable "pm_target_node" {
  type    = string
}

variable "pm_api_url" {}
variable "pm_api_token_id" {}
variable "pm_api_token_secret" {}
variable "pm_host" {}
variable "pm_user" {}
variable "pm_password" {}
variable "pm_private_key_file" {}

variable "pm_tls_insecure" {
  type    = bool
  default = true
}

variable "vm_user" {
  type    = string
  default = "ubuntu"
}
