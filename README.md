# OCF Resource Agent Samle

## Install

## Pre-condition
You need to complete setup pacemaker and pcs command before install this sample code.

## Install

```
git clone https://github.com/kamaboko123/OCF_resource_agent_sample.git
cd OCF_resource_agent_sample
make
sudo dpkg -i dist/sampletcpserver_1.0_amd64.deb
```

## Run
### Run test
```
sudo ocf-tester -n sample /usr/lib/ocf/resource.d/kamaboko/sample-tcp-server
```

### Run as resource of cluster
```
sudo pcs resource create TCP-SERVER ocf:kamaboko:sample-tcp-server greet=Hi!
```

optional)
Configure constraint to run sample-tcp-server and VRRP in same node.
```
sudo pcs resource create VIP ocf:heartbeat:IPaddr2 ip=172.16.0.50 cidr_netmask=24 op monitor interval=10s on-fail="standby"
sudo pcs constraint colocation add TCP-SERVER with VIP INFINITY
```


## Daemon
### daemon/tcp-server
This daemon is simple application for this sample OCF resource agent.  
The daemon is TCP server which is send following message to client.  
`{GREET} This is {HOSTNAME}!`  
`{GREET}` is replaced to environment variable `GREET`.(default: Hello!)  
`{HOSTNAME}` is replaced to hostname of server.  

## Reference
[OCFリソースエージェント開発者ガイド « Linux-HA Japan](https://linux-ha.osdn.jp/wp/archives/4328)

