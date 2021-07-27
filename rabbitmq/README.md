##########Rabit-MQ-Auto-PV-create#####
https://github.com/kubernetes-retired/external-storage/tree/master/nfs-client/deploy

###########Mirroring-Command########
```

Before run following command first exec to any pod like the first rabbitmq-0 pod and run the following command

rabbitmqctl set_policy ha-fed \
    ".*" '{"federation-upstream-set":"all", "ha-sync-mode":"automatic", "ha-mode":"nodes", "ha-params":["rabbit@rabbitmq-0.rabbitmq.rabbits.svc.cluster.local","rabbit@rabbitmq-1.rabbitmq.rabbits.svc.cluster.local","rabbit@rabbitmq-2.rabbitmq.rabbits.svc.cluster.local"]}' \
    --priority 1 \
    --apply-to queues
```
####After complete cluster than build docker image and deploy the same at K8##########
```
docker build -t docker-hub.land.gov.bd/rabbit-haproxy .
docker push docker-hub.land.gov.bd/rabbit-haproxy
