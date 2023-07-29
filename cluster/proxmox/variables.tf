variable "cluster_name" {}
variable "nfs_server_path" {}
variable "pm_network" {}
variable "pm_cdrom_storage" {}
variable "pm_disk_storage" {}
variable "ssh_public_key_file" {}
variable "master_node_count" {}
variable "worker_node_count" {}
variable "master_cpu_count" {}
variable "worker_cpu_count" {}
variable "master_node_memory" {}
variable "worker_node_memory" {}
variable "pm_vm_template" {}
variable "pm_target_node" {}
variable "pm_host" {}
variable "pm_api_url" {}
variable "pm_api_token_id" {}
variable "pm_api_token_secret" {}
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
