#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentDIR="$(dirname "$DIR")"
grandparentDIR="$(dirname "$parentDIR")"
greatgrandparentDIR="$(dirname "$grandparentDIR")"
xhost + && \
xterm -e docker rm `docker ps --no-trunc -aq` && \
xterm -e docker run -ti --rm -e DISPLAY=$DISPLAY -v $greatgrandparentDIR/CymeR-Workspace:/home/developer/knime-workspace -v $greatgrandparentDIR/Scripts:/home/developer/Scripts -v $greatgrandparentDIR/CymeR-Data:/home/developer/Data:rw -v $greatgrandparentDIR/Templates:/home/developer/Templates:rw -v /tmp/.X11-unix:/tmp/.X11-unix:rw bmuchmore/cymer
xterm -e docker rm `docker ps --no-trunc -aq`




