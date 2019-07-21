## To see traffic
$ netstat -r

## Add gateway in linux environment not permanent. The configuration will be evected once vm/bearmatel restarts
$ route add -host IP_OF_HOST_TO_ROUTED gw GATEWAY_THROUGH_WHICH_TRAFIC_ROUTED
# Example 10.110.119.58 is deployment of kubernetes cluster and 192.168.0.140 IP of master node.
<code>$ route add -host 10.110.119.58 gw 192.168.0.140</code>



root@ub-java:~# cd /etc/netplan/
50-cloud-init.yaml  50-cloud-init.yaml.backup  50-cloud-init.yaml.backup.router

root@ub-java:/etc/netplan# cat 50-cloud-init.yaml.backup.router

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
![home_rowter](https://drive.google.com/uc?id=1eL2Zt9UKgWmtsCxIPuPxagFzu8YlVBwY)
