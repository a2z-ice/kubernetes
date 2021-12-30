# Example for single cluster:
https://www.youtube.com/watch?v=h6YtDQ-Qtsk

# Example for multi cluster
https://www.youtube.com/watch?v=Qzp_gSDCuuU
```
# check certificate expiration
kubeadm certs --help
# Follow the following steps
1. kubeadm certs check-expiration
2. Backup all file and folder under /etc/kubernetes
3. kubeadm certs renew all (all means all apis for individual example mention api name like apiserver found name from expiration command also chekc with --help command for available options)
# To check certificate using server ip/address
4. echo | openssl s_client -showcerts -connect 172.16.16.199:6443 (ip of master or LB) -servername api 2>/dev/null | openssl x509 -noout -enddate 
```
