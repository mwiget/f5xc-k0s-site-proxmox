resource "local_file" "cloud_init_user_data_master" {
  count   = var.master_node_count
  content  = templatefile("${path.module}/templates/cloud_init_master.yaml", {
    host-name    = format("%s-m%d", var.cluster_name, count.index),
    vm_user      = var.vm_user,
    cluster_name = var.cluster_name,
    ssh_key      = file(var.ssh_public_key_file)
  })
  filename = "${path.module}/files/user_data_${var.cluster_name}_m${count.index}.cfg"
}

resource "local_file" "cloud_init_user_data_worker" {
  count   = var.worker_node_count
  content  = templatefile("${path.module}/templates/cloud_init_worker.yaml", {
    host-name    = format("%s-w%d", var.cluster_name, count.index),
    vm_user      = var.vm_user,
    cluster_name = var.cluster_name,
    ssh_key      = file(var.ssh_public_key_file)
  })
  filename = "${path.module}/files/user_data_${var.cluster_name}_w${count.index}.cfg"
}

resource "null_resource" "cloud_init_master" {
  count   = var.master_node_count
#  triggers = {
#    always_run = timestamp()
  #  }
  connection {
    type     = "ssh"
    user     = var.pm_user
    #    password = var.pm_password
    private_key = file(var.pm_private_key_file)
    host     = var.pm_host
  }

  provisioner "file" {
    source      = local_file.cloud_init_user_data_master[count.index].filename
    destination = "/var/lib/vz/snippets/user_data_${var.cluster_name}_m${count.index}.yml"
  }
  #  depends_on = [ local_file.cloud_init_user_data_file ]
}

resource "null_resource" "cloud_init_worker" {
  count   = var.worker_node_count
  #triggers = {
  #  always_run = timestamp()
  #}
  connection {
    type     = "ssh"
    user     = var.pm_user
    #    password = var.pm_password
    private_key = file(var.pm_private_key_file)
    host     = var.pm_host
  }

  provisioner "file" {
    source      = local_file.cloud_init_user_data_worker[count.index].filename
    destination = "/var/lib/vz/snippets/user_data_${var.cluster_name}_w${count.index}.yml"
  }
  #  depends_on = [ local_file.cloud_init_user_data_file ]
}

