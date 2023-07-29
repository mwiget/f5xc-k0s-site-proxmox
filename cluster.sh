#!/bin/bash
cluster=$1
[ -z "$cluster" ] && echo "specify cluster" && exit 1
cp ./$cluster.kubeconfig  ~/.kube/config
