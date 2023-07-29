module "beta" {
  source              = "./proxmox"
  cluster_name        = "beta"
  master_node_count   = 1
  worker_node_count   = 3

  master_cpu_count    = 2
  master_node_memory  = 4096

  worker_cpu_count    = 4
  worker_node_memory  = 16384

  vm_user             = var.vm_user
  ssh_public_key_file = var.ssh_public_key_file 
  nfs_server_path     = var.nfs_server_path

  pm_target_node      = var.pm_target_node  
  pm_network          = var.pm_network
  pm_vm_template      = var.pm_vm_template 
  pm_cdrom_storage    = var.pm_cdrom_storage
  pm_disk_storage     = var.pm_disk_storage
  pm_host             = var.pm_host
  pm_api_url          = var.pm_api_url  
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_user             = var.pm_user
  pm_password         = var.pm_password
  pm_private_key_file = var.pm_private_key_file
}

output "beta" {
  value = module.beta
  sensitive = true
}

output "beta_ssh_host" {
  value = module.beta.master[0].ssh_host
}
