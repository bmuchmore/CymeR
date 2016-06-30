#!/bin/bash
docker-machine create --driver virtualbox cymer ;
docker-machine start cymer ;
eval "$(docker-machine env cymer)" ;
CID=$(docker ps -l -q) ;
docker rm `docker ps --no-trunc -aq` ;
docker commit $CID bmuchmore/cymer ;
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

