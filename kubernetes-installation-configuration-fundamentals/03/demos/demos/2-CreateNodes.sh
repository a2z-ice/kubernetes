#For this demo ssh into c1-node1
vim /etc/hosts
192.168.0.140 ubuntu-140
192.168.0.141 ubuntu-141

#Disable swap, swapoff then edit your fstab removing any entry for swap partitions
#You can recover the space with fdisk. You may want to reboot to ensure your config is ok. 
swapoff -a
vi /etc/fstab

#Add the Google's apt repository gpg key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

#Add the kuberentes apt repository
sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF'

#Update the package list 
sudo apt-get update
apt-cache policy kubelet | head -n 20 

#Install the required packages, if needed we can request a specific version
sudo apt-get install -y docker.io kubelet kubeadm kubectl
sudo apt-mark hold docker.io kubelet kubeadm kubectl

#Check the status of our kubelet and our container runtime, docker.
#The kubelet will enter a crashloop until it's joined
sudo systemctl status kubelet.service 
sudo systemctl status docker.service 

#Ensure both are set to start when the system starts up.
sudo systemctl enable kubelet.service
sudo systemctl enable docker.service

#If you didn't keep the output, on the master, you can get the token.
kubeadm token list

#If you need to generate a new token, perhaps the old one timed out/expired.
kubeadm token create

#On the master, you can find the ca cert hash.
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'

#Using the master (API Server) IP address or name, the token and the cert has, let's join this Node to our cluster.

sudo kubeadm join 192.168.0.140:6443 \
    --token NAME_OF_TOKEN_FROM_TOKEN_LIST \
    --discovery-token-ca-cert-hash sha256:VALIE_FROM_ABOVE_COMMAND_x509


sudo kubeadm join 192.168.0.140:6443 \
    --token o775us.cqjgtnk2ibh90361 \
    --discovery-token-ca-cert-hash sha256:14ebe3f101e6065c8d4e9f70c75801c4f2236c0b25e753352b4f01ddf2b69987
    
    
    

#Back on master, this will say NotReady until the networking pod is created on the new node. Has to schedule the pod, then pull the container.
kubectl get nodes 

#On the master, watch for the calico pod and the kube-proxy to change to Running on the newly added nodes.
kubectl get pods --all-namespaces --watch

#Still on the master, look for this added node's status as ready.
kubectl get nodes

#GO BACK TO THE TOP AND DO THE SAME FOR c1-node2.
#Just SSH into c1-node2 and run the commands again.
ssh aen@c1-node2
#You can skip the token re-creation if you have one that's still valid.
