#!/bin/bash


docker kill icecast-fsg
docker rm -f icecast-fsg
docker rmi -f icecast-fsg
time docker compose -f docker-compose.yml -f docker-compose-build.yml build

# log into docker container
# docker exec -it icecast-kh bash
