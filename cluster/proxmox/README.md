## Create Ubuntu cloud template for Proxmox

To be executed on the proxmox server

```
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
qm create 9002 --memory 2048 --scsihw virtio-scsi-pci
qm set 9002 --scsi0 local-zfs:0,import-from=/root/jammy-server-cloudimg-amd64.img
qm set 9002 --boot order=scsi0
qm set 9002 --serial0 socket --vga serial0
qm resize 9002 scsi0 50G
qm set 9002 --ipconfig0 ip=dhcp
qm template 9002
qm set 9002 --name "ubuntu-2204-template"
```
