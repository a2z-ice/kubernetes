# kubernetes maintainance 
```
kubectl taint nodes k8-slave-1bk delete-node=app:NoSchedule

# uncordon only make node unschedulable on the pod which is cordon
kubectl cordon node03.kubernetes.com

# drain will cordon node03 first and then evict all pod from node03 to available node
kubectl drain node03.kubernetes.com --ignore-daemonsets
```
# To show available api resources in kubernetes with theor shortcut
```
kubectl api-resources
```
# ETCD backup and Restore

```
------------------Backup etcd------------------------
ETCDCTL_API=3 etcdctl snapshot save -h
ETCDCTL_API=3 etcdctl snapshot save --cert=/etc/kubernetes/pki/etcd/server.crt --cacert=/etc/kubernetes/pki/etcd/ca.crt  --key=/etc/kubernetes/pki/etcd/server.key --endpoints=https://127.0.0.1:2379 /opt/snapshot-pre-boot.db




------------------Restore etcd------------------------
ETCDCTL_API=3 etcdctl snapshort restore -h

please be careful only one space before "/opt/snapshot-pre-boot.db"

ETCDCTL_API=3 etcdctl snapshot restore --cacert=--cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key --endpoints=https://127.0.0.1:2379 --data-dir="/var/lib/etcd-from-backup" --initial-cluster="controlplane=https://127.0.0.1:2380" --name=controlplane --initial-advertise-peer-urls=https://127.0.0.1:2380 --initial-cluster-token="etcd-cluster-controlplane-1" /opt/snapshot-pre-boot.db

Open file from /etc/kubernetes/manifest/etcd.yaml for static pod configuration

change the value of --data-dir to "/var/lib/etcd-from-backu" add "--initial-cluster-token=etcd-cluster-controlplane-1" after "--data-dir" go to mount and replace "/var/lib/etcd" to "/var/lib/etcd-from"-backup and also in hostlocation option

Steps:
1. run restore command and add new data directory with new uniquc cluster token
2. Change static etcd pod menifest file and chage data-dir and add unique cluster token
3. Change etct volume for newly configure data directory at step 2

The staic pod will be restarted and if all goes well 
```

# Deployment rollout
<pre><code>
kubectl rollout history deploy fastpass-service -n industry-4-0 ⇐ fastpass-service name of deployment
kubectl rollout undo deploy fastpass-service -n industry-4-0 --to-revision=1

#For basic authentication
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
    httpHeaders:
      - name: Authorization
        value: Basic aGE6aGE=
</code></pre>

## To see traffic
<code>$ netstat -r </code>

## Add gateway in linux environment not permanent. The configuration will be evected once vm/bearmatel restarts
$ route add -host IP_OF_HOST_TO_ROUTED gw GATEWAY_THROUGH_WHICH_TRAFIC_ROUTED
# Example 10.110.119.58 is deployment of kubernetes cluster and 192.168.0.140 IP of master node.
<code>$ route add -host 10.110.119.58 gw 192.168.0.140



root@ub-java:~# cd /etc/netplan/
50-cloud-init.yaml  50-cloud-init.yaml.backup  50-cloud-init.yaml.backup.router

root@ub-java:/etc/netplan# cat 50-cloud-init.yaml.backup.router
</code>
## Add menual gateway for Permanant by editing network interface
<pre><code>
# This file is generated from information provided by
# the datasource.  Changes to it will not persist across an instance.
# To disable cloud-init's network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        enp0s3:
            addresses: [192.168.0.120/24]
            gateway4: 192.168.0.1
            nameservers:
                 addresses: [103.84.36.5,8.8.8.8]
            routes:
                 - to: 10.99.0.0/16 <== IP of the deployment pod network wise or complite IP will also work
                   via: 192.168.0.140 <== IP of master node
            dhcp4: no
    version: 2
</code></pre>
## Fro router configuration it is not needed to configure the router in interface just configure the router like following example
![home_rowter](https://drive.google.com/uc?id=1eL2Zt9UKgWmtsCxIPuPxagFzu8YlVBwY)
![home_rowter_list](https://drive.google.com/uc?id=14aDWTo8qAJc1agxLditE_fZ_pbiujkUl)

