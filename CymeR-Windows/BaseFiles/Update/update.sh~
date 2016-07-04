#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ;
parentDIR="$(dirname "$DIR")" ;
realDIR="${DIR#*/cygdrive}" ;
echo $realDIR ;
eval "$(docker-machine env cymer)" ;
##For some weird reason the symlinks are not working and the Dockerfile is expected to be in C:\Users\Cytof2-118\.babun\cygwin\home\Cytof2-118
##So, lets just copy the Dockerfile there and overwrite a Dockerfile if it is already present. This command will be carried out in Update.bat
##cp -f $realDIR/Dockerfile /c/Users/$USER/Desktop/.babun/cygwin/home/$USER/Dockerfile ;
docker build -t bmuchmore/cymer . ;
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")