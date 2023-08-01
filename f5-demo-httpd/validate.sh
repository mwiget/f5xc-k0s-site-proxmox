#!/bin/bash
export KUBECONFIG=../alpha.kubeconfig
internalip=$(kubectl get nodes -o json | \
	    jq -r '.items[].status.addresses[]? | select (.type == "InternalIP") | .address' | \
	      paste -sd "\n" -)

echo ""
kubectl get services
port=$(kubectl get services -o json | jq -r '.items[0].spec.ports[0].nodePort')
name=$(kubectl get services -o json | jq -r '.items[0].metadata.name')
echo ""
echo "Testing LB with 'curl -H Host:$name http://<nodeIp>:$port' ..."
echo ""

for ip in $internalip; do
  echo -n "$ip:$port ..."
  curl --silent -f -H Host:$name http://$ip:$port/txt | grep 'Server IP:'
done

echo ""
echo "Testing LB with wrk ..."
echo ""

for ip in $internalip; do
  wrk -H Host:$name http://$ip:$port/txt
  echo ""
done

