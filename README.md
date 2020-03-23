# Monitoring
Full stack tools for monitoring containers and other stuff. ;)
- Netdata
- Prometheus
- Docker
- Grafana
- cAdvisor

# Howto
First of all, clone the monitoring repo:
```
# git clone https://github.com/madson7/monitoring.git
```

## Install Docker and create Swarm cluster
```
# curl -fsSL https://get.docker.com | sh
# docker swarm init
```

## Install Netdata:
```
# bash <(curl -Ss https://my-netdata.io/kickstart.sh)
```

Setting Netdata Exporter configuration in Prometheus:
```
# nano conf/prometheus/prometheus.yml
...
- job_name: 'netdata'
    metrics_path: '/api/v1/allmetrics'
    params:
      format: [prometheus]
    honor_labels: true
    scrape_interval: 5s
    static_configs:
         - targets: ['YOUR_IP:19999']
```



## Deploy Stack with Docker Swarm

Execute deploy to create the stack of monitoring:
```
# docker stack deploy -c docker-compose.yml monitor

Creating network monitor_backend
Creating network monitor_frontend
Creating network monitor_default
Creating service monitor_prometheus
Creating service monitor_grafana
```

Verify if services are ok:
```
# docker service ls
ID                  NAME                 MODE                REPLICAS            IMAGE                              PORTS
vcwsr36mxwyf        monitor_grafana      replicated          1/1                 grafana/grafana:latest             *:3000->3000/tcp
x8g1ti2w40k1        monitor_prometheus   replicated          1/1                 madson7/prometheus_alpine:latest   *:9090->9090/tcp
```
## Access Services in Browser

To access Prometheus interface on browser:
```
http://YOUR_IP:9090
```

To access Grafana interface on browser:
```
http://YOUR_IP:3000
user: admin
passwd: admin

To add plugs edit file monitoring/grafana.config
GF_INSTALL_PLUGINS=plug1,plug2
Current plugs grafana-clock-panel,grafana-piechart-panel,camptocamp-prometheus-alertmanager-datasource,vonage-status-panel
```
Have fun, access the dashboards! ;)

To access Netdata interface on browser:
```
http://YOUR_IP:19999
```
Create new alerts on Prometheus:
```
# vim conf/prometheus/alert.rules
```