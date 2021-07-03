
# configuration redis-config
```
bind 0.0.0.0
appendonly yes
requirepass SuperSecretSecureStrongPass
dir /data/
loglevel debug
maxmemory 4294967296

save 3600 1
save 300 100
save 60 10000
```
# bench marking in redis-cli
```
redis-benchmark -t set -c 100 -n 1000000
redis-benchmark -t set,get -d 1000000 -n 1000 -q
```

# Nginx
```
#####NGINX-WORKER-LOAD-CHEK#####
# From linux terminal
ulimit -Hn
ulimit -Sn

vi /etc/security/limits.conf (add this value)
nginx soft nofile 10000
nginx hard nofile 30000

vi /etc/sysctl.conf
fs.file-max = 70000 (add this value)

sysctl -p

# from nginx configuration file
vi /etc/nginx/nginx.conf   ( add below values)

events {
    worker_connections 16384;
}
   worker_rlimit_nofile 30000;
```
