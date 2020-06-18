# OCF Resource Agent Samle

## Run test
```
git clone https://github.com/kamaboko123/OCF_resource_agent_sample.git
cd OCF_resource_agent_sample
sudo ./test.sh
```

## Daemon
### daemon/tcp-server
This daemon is simple application for this sample OCF resource agent.  
The daemon is TCP server which is send following message to client.  
`{GREET}, This is {HOSTNAME}!`  
`{GREET}` is replaced to environment variable `GREET`.(default: Hello!)  
`{HOSTNAME}` is replaced to hostname of server.  

## Reference
[OCFリソースエージェント開発者ガイド « Linux-HA Japan](https://linux-ha.osdn.jp/wp/archives/4328)

