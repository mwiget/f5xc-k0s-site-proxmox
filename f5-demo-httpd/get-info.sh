#!/bin/bash
for node in alpha beta; do 
  echo ""
  echo "=============> $node <======================"
  export KUBECONFIG=../$node.kubeconfig
  echo ""
  kubectl get services
  echo ""
  kubectl get services -n marcel-k0s-site
  echo ""
  kubectl get nodes -o wide
  echo ""
  kubectl get pods -o custom-columns=Name:.metadata.name,NS:.metadata.namespace,HostIP:.status.hostIP,PodIP:status.podIP -n marcel-k0s-site
  echo ""
done
