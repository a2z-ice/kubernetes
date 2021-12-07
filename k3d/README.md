http://localhost:8086/fastpass?fastpassid=100

# Pring all nodeport's ports
```
kubectl get svc --all-namespaces -o go-template='{{range .items}}{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}{{end}}'
```
