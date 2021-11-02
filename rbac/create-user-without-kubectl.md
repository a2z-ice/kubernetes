```
openssl genrsa -out superuserad.key 2048

openssl req -new -key superuserad.key -subj "/CN=superuserad/O=system:masters" -out superuserad.csr

# ca.crt file location  --client-ca-file=/etc/kubernetes/pki/ca.crt
openssl x509 -req -in superuserad.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out superuserad.crt -days 1000

# Verification
 kubectl get secret --server=https://IP-ADDRESS-OF-MASTER-CLUSTER:6443 --client-certificate superuserad.crt --certificate-authority /etc/kubernetes/pki/ca.crt --client-key superuserad.key
 
 # Verification without ca.crt
 kubectl get ns -o wide --server=https://IP-ADDRESS-OF-MASTER-CLUSTER:6443 --client-certificate superuserad.crt --client-key superuserad.key
 
 #Create kubeconfig file
 
 export SERVER_IP=IP-ADDRESS-OF-MASTER-CLUSTER
 
 kubectl config set-cluster kubeadm \
 --certificate-authority=/etc/kubernetes/pki/ca.crt \
 --embed-certs=true \
 --server=https://${SERVER_IP}:6443 \
 --kubeconfig=superuserad.kubeconfig
 
 # Set credentials for user superuserad
 
 kubectl config set-credentials superuserad \
 --client-certificate=superuserad.crt \
 --client-key=superuserad.key \
 --embed-certs=true \
 --kubeconfig=superuserad.kubeconfig
 
 # Set context 

 kubectl config set-context default \
 --cluster=kubeadm \
 --user=superuserad \
 --kubeconfig=superuserad.kubeconfig
 
 # Use context
 kubectl config use-context default --kubeconfig=superuserad.kubeconfig
 
```
