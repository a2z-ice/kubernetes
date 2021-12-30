# Example for single cluster:
https://www.youtube.com/watch?v=h6YtDQ-Qtsk

# Example for multi cluster follow the steps to each master node
https://www.youtube.com/watch?v=Qzp_gSDCuuU
```
# check certificate expiration
kubeadm certs --help
# Follow the following steps
1. kubeadm certs check-expiration
2. Backup all file and folder under /etc/kubernetes
cp -p /etc/kubernetes/*.conf /root/kube-backup
cp -pr /etc/kubernetes/pki /root/kube-backup

3. kubeadm certs renew all (all means all apis for individual example mention api name like apiserver found name from expiration command also chekc with --help command for available options)
4. For crictl 
export CONTAINER_RUNTIME_ENDPOINT=///var/run/containerd/containerd.sock
crictl pods
crictl ps
# you can remove the pod one by one using circtl rmp command or docker rm command. To make all at once 
cd /etc/kubernetes/manifests/
mv *.yaml /tmp/kube-backup/
# Once all pods or container is gone move back the manifest file to the /etc/kubernetes/manifests folder location
mv /tmp/kube-backup/*.yaml /etc/kubernetes/manifests/

# To check certificate using server ip/address
4. echo | openssl s_client -showcerts -connect 172.16.16.199:6443 (ip of master or LB) -servername api 2>/dev/null | openssl x509 -noout -enddate 
```
