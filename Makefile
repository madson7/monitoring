.PHONY init start

init:
	docker swarm init

start:
	docker stack deploy -c docker-compose.yml giropops

service:
	docker service ls

remove:
	docker stack rm giropops
	docker image rm $(docker image ls -a -q)