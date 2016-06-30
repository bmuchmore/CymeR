#!/bin/bash
eval "$(docker-machine env cymer)"
CID=$(docker ps -l -q)
docker commit $CID bmuchmore/cymer
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
