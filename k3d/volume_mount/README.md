# K3d volume mount example
```bash

# In host machine create folder 
mkdir -p /tmp/k3dvol

# If you have multiple server mean master and want to apply volume to all then use server:* and if there are separate agent then add agent along with server like `server:0;agent:*` which refers volume mount for server-0 and all agent. Agent is worker
k3d cluster create  --volume '/tmp/k3dvol:/tmp/k3dvol@server:0'

# example https://blog.ruanbekker.com/blog/2020/02/21/persistent-volumes-with-k3d-kubernetes/

kubectl create k3d-volume-mounted-app.yaml

# exec to newly create pod
kubectl exec -it echo-58fd7d9b6-x4rxj sh

echo $(hostname)
echo-58fd7d9b6-x4rxj
echo $(hostname) > /data/hostname.txt
exit
# check the host maching 
cat /tmp/k3dvol/hostname.txt
# Will print following message
echo-58fd7d9b6-x4rxj
```
