#!/bin/bash
CID=$(docker ps -l -q)
xterm -e docker rm `docker ps --no-trunc -aq` && \
xterm -e docker commit $CID bmuchmore/cymer && \
xterm -e docker rmi $(docker images | grep "^<none>" | awk "{print $3}")


