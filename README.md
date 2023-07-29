# f5xc-k0s-site-proxmox

Deploy k0s clusters with 1 or more worker nodes on proxmox and deploy F5 XC kubernetes site (ce pod) on them.

## Deployment

First 2 k0s clusters alpha and beta:

```
cd cluster
terraform apply
```

This will generate alpha.kubeconfig and beta.kubeconfig in the directory above cluster. These are used
to deploy F5 XC Kubernetes CE's in both clusters with

```
cd ../ce_k0s
terraform apply
```

Once ONLINE, check pods with

```
$ ./cluster-info.sh

alpha .... 

Kubernetes control plane[0m is running at [https://192.168.40.68:6443
CoreDNS[0m is running at [https://192.168.40.68:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

NAME       STATUS   ROLES    AGE   VERSION
alpha-w0   Ready    <none>   21h   v1.23.15+k0s
alpha-w1   Ready    <none>   21h   v1.23.15+k0s
alpha-w2   Ready    <none>   21h   v1.23.15+k0s

NAME                          READY   STATUS    RESTARTS        AGE
etcd-0                        2/2     Running   0               31m
etcd-1                        2/2     Running   0               31m
etcd-2                        2/2     Running   0               31m
prometheus-785c874d46-4w2n7   5/5     Running   0               31m
ver-0                         17/17   Running   1 (9m17s ago)   31m
ver-1                         17/17   Running   1 (9m25s ago)   29m
ver-2                         17/17   Running   1 (9m23s ago)   27m
volterra-ce-init-dxp67        1/1     Running   0               35m
volterra-ce-init-z56x7        1/1     Running   0               35m
volterra-ce-init-zbpnx        1/1     Running   0               35m
vp-manager-0                  1/1     Running   3 (22m ago)     34m
vp-manager-1                  1/1     Running   2 (31m ago)     34m
vp-manager-2                  1/1     Running   2 (32m ago)     34m

beta ...

[0;32mKubernetes control plane[0m is running at [0;33mhttps://192.168.40.80:6443[0m
[0;32mCoreDNS[0m is running at [0;33mhttps://192.168.40.80:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy[0m

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

NAME      STATUS   ROLES    AGE   VERSION
beta-w0   Ready    <none>   20h   v1.23.15+k0s
beta-w1   Ready    <none>   20h   v1.23.15+k0s
beta-w2   Ready    <none>   20h   v1.23.15+k0s

NAME                          READY   STATUS    RESTARTS      AGE
etcd-0                        2/2     Running   0             33m
etcd-1                        2/2     Running   0             33m
etcd-2                        2/2     Running   0             33m
prometheus-66ddf5c796-9n4jh   5/5     Running   0             32m
ver-0                         17/17   Running   2 (10m ago)   32m
ver-1                         17/17   Running   2 (10m ago)   31m
ver-2                         17/17   Running   2 (10m ago)   27m
volterra-ce-init-c5nnb        1/1     Running   0             35m
volterra-ce-init-t5kp7        1/1     Running   0             35m
volterra-ce-init-xkbfm        1/1     Running   0             35m
vp-manager-0                  1/1     Running   3 (23m ago)   34m
vp-manager-1                  1/1     Running   2 (33m ago)   34m
vp-manager-2                  1/1     Running   2 (33m ago)   34m
```
