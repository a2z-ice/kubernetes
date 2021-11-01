```
openssl genrsa -out superuserad.key 2048

openssl req -new -key superuserad.key -subj "/CN=superuserad/O=system:masters" -out superuserad.csr

openssl x509 -req -in superuserad.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out superuserad.crt -days 1000

# Verification
kubectl get secret --server=https://127.0.0.1:6443 --client-certificate /root/cartificates/superuserad.crt

```