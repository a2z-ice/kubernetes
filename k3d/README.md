# expose service using loadbalancer
```
k3d cluster create --config v1alpha4-disable-treafik.yaml
# Create a service with loadbalancer on 8081 port and then access
http://localhost:8081/
```

```
k3d cluster create --config config-file.yaml

http://localhost:8082/
```

http://localhost:8086/fastpass?fastpassid=100

# Pring all nodeport's ports
```
kubectl get svc --all-namespaces -o go-template='{{range .items}}{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}{{end}}'
```
