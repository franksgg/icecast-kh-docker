#!/bin/bash


docker kill icecast-kh
docker rm -f icecast-kh
docker rmi -f icecast-kh
time docker compose -f docker-compose.yml -f docker-compose-build.yml build

# log into docker container
# docker exec -it icecast-kh bash
