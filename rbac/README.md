To show available api resources in kubernetes with theor shortcut
```
kubectl api-resources
```
Source: https://documentation.commvault.com/11.21/essential/129225_creating_kubeconfig_file_for_kubernetes_authentication.html
You can use the Kubernetes kubeconfig file for authentication.

You can use only user name- or token-based authentication in the configuration file.

# Procedure
Fetch the token from the secret, noting the value for the token.
```
kubectl describe secrets cvbackup
```
Get the certificate information for the cluster, noting the values for certificate-authority-data and server.
```
kubectl config view --flatten --minify > cluster-cert.txt
cat cluster-cert.txt
```
At this point, you have values for token, certificate-authority-data, and server.

Create a file kubeconfig with the following content and replace the values for SERVER, CERTIFICATE_AUTHORITY_DATA, and TOKEN.
```
apiVersion: v1
kind: Config
preferences: {}
clusters:
- name: k8s-cluster
  cluster:
    certificate-authority-data: CERTIFICATE_AUTHORITY_DATA
    server: SERVER
contexts:
- name: cv-backup-context
  context:
    cluster: k8s-cluster
    namespace: default
    user: cvbackup
current-context: cv-backup-context
users:
- name: cvbackup
  user:
    token: TOKEN
```    

# Example:
```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: CERTIFICATE_AUTHORITY_DATA
    server: https://SERVER-IP-OR-HOSTNAME:6443
  name: kanon-kubernetes
contexts:
- context:
    cluster: kanon-kubernetes
    user:  k8s-dashboard-viewer
  name: k8s-dashboard-viewer@kanon-kubernetes
current-context: k8s-dashboard-viewer@kanon-kubernetes
kind: Config
preferences: {}
users:
- name:  k8s-dashboard-viewer
  user:
    token: TOKEN
```
