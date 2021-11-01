```
openssl genrsa -out superuserad.key 2048

openssl req -new -key superuserad.key -subj "/CN=superuserad/O=system:masters" -out superuserad.csr

# ca.crt file location  --client-ca-file=/etc/kubernetes/pki/ca.crt
openssl x509 -req -in superuserad.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out superuserad.crt -days 1000

# Verification
 kubectl get secret --server=https://IP-ADDRESS-OF-MASTER-CLUSTER:6443 --client-certificate superuserad.crt --certificate-authority /etc/kubernetes/pki/ca.crt --client-key superuserad.key

```
