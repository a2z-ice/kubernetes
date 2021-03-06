# RBAC service account scenario

```
Create namespace blue
kubectl create ns blue

Deploy pod in blue namesapce
kubectl run nginx --image=nginx -n blue

Create service account assad in default namespace
kubectl create sa assad -n default

Create clusterrole and rolebinding for default:assad so that this service account has access to list namespace
kubectl create clusterrole nslist --verb=list,get,watch --resource=namespaces
kubectl create clusterrolebinding assadnslist --clusterrole nslist --serviceaccount=default:assad

# to test access -A for all namespaces
kubectl auth can-i list namespace --as system:serviceaccount:default:assad -A

Create clusterrole with podlist name so that this allow to access pod list
kubectl create clusterrole podviewer --verb=list,get,watch --resource=pods,pods/log

Create rolebinding in blue namespace to bind default:assad service account with cluster role podlist so that default:assad service account can list pods in blue namespace
kubectl -n blue create rolebinding assad --clusterrole podviewer --serviceaccount default:assad

# test pod list in blue namespace
kubectl auth can-i list po --as system:serviceaccount:default:assad -n blue

```

To show available api resources in kubernetes with theor shortcut
```
kubectl api-resources -o wide

# to test rback
# To test service account permission
```
kubectl auth can-i get pods --as=system:serviceaccount:<namespace>:<service account name> -n <namespace>
kubectl auth can-i get pods --as=system:serviceaccount:default:k8s-dev-view-sa -n default
```
# For specefic user
```
kubectl auth can-i create pods --as <user name> --namespace <namespace name>

# For default namesapce
kubectl auth can-i create pods --as <user name>

```
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
