.PHONY init start

init:
	docker swarm init

build:
	docker build -t madson7/prometheus_alpine ./dockerfiles/prometheus

start:
	docker stack deploy -c docker-compose.yml monitor

service:
	docker service ls

remove:
	docker stack rm monitor
	docker image rm $(docker image ls -a -q)