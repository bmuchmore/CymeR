#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentDIR="$(dirname "$DIR")"
sudo true && \
sudo docker build -t bmuchmore/cymer $DIR/BaseFiles/Update && \
sudo docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
read -p "*** YOU CAN NOW CLOSE ME ***"
