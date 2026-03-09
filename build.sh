#!/bin/bash


docker kill icecast-fsg
docker rm -f icecast-fsg
docker rmi -f icecast-fsg
rm data/iceshake.fdb
time docker compose -f docker-compose.yml -f docker-compose-build.yml build

# log into docker container
# docker exec -it icecast-fsg bash
