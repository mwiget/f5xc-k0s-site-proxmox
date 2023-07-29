#!/bin/bash

cd cluster
clusters=$(terraform output |grep ssh_host |cut -d_ -f1)
for cluster in $clusters; do
  echo -n "$cluster -> "
  ssh_host=$(terraform output -json | jq -r ".$cluster.value.master[0].ssh_host")
  ssh -StrictHostKeyChecking=no $ssh_host  sudo k0s kubeconfig admin > ../$cluster.kubeconfig
  ls ../$cluster.kubeconfig
done

