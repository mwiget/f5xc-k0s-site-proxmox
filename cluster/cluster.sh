#!/bin/bash
cluster=$1
[ -z "$cluster" ] && echo "specify cluster" && exit 1
ssh_host=$(terraform output -json | jq -r ".$cluster.value.master[0].ssh_host")
echo "grabbing admin kubeconfig for $cluster ($ssh_host) into ~/.kube/config ..."

ssh -StrictHostKeyChecking=no $ssh_host  sudo k0s kubeconfig admin > ~/.kube/config
