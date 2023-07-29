#!/bin/bash
for cluster in alpha beta; do
  echo ""
  echo "$cluster ..."
  echo ""
  kubectl --kubeconfig ./$cluster.kubeconfig cluster-info
  echo ""
  kubectl --kubeconfig ./$cluster.kubeconfig get nodes
  echo ""
  kubectl --kubeconfig ./$cluster.kubeconfig get pods -n ves-system
done
exit

