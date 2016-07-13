#!/bin/bash
ip=`route print | egrep "^ +0.0.0.0 +0.0.0.0 +" | gawk 'BEGIN { metric=255; ip="0.0.0.0"; } { if ( $5 < metric ) { ip=$4; metric=$5; } } END { printf("%s\n",ip); }'`
##IP failure is relatively common, so you may want to set it manually on the line below, and comment out (i.e. #) the line above.
#ip=195.83.246.150
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ;
parentDIR="$(dirname "$DIR")" ;
grandparentDIR="$(dirname "$parentDIR")" ;
greatgrandparentDIR="$(dirname "$grandparentDIR")" ;
realgreatgrandparentDIR="${greatgrandparentDIR#*/cygdrive}" ;
rm -rf /home/$USER/.Xauthority* ;
echo Current ip is $ip 1>&2 ;
export DISPLAY=$ip:5.0 ;
echo The display is set to $DISPLAY ;
rm -rf /home/$USER/.themes ;
mkdir /home/$USER/.themes ;
rm -rf /home/$USER/.xinitrc ;
echo "if [ -d /etc/X11/xinit/xinitrc.d ] ; then" > /home/$USER/.xinitrc ;
echo     "for f in /etc/X11/xinit/xinitrc.d/?* ; do" >> /home/$USER/.xinitrc ;
echo         "[ -x '$f' ] && . '$f'" >> /home/$USER/.xinitrc ;
echo     "done" >> /home/$USER/.xinitrc ;
echo     "unset f" >> /home/$USER/.xinitrc ;
echo "fi" >> /home/$USER/.xinitrc ;
echo "exec openbox-session" >> /home/$USER/.xinitrc ;
startx -- :5 -rootless -listen tcp &
sleep 5 ;
docker-machine start cymer ;
echo Waiting 15 seconds to make sure everything has loaded. If the KNIME splash screen does not appear after ~15 seconds, trying closing and reopening. ;
sleep 15 ;
eval "$(docker-machine env cymer)" ;
xhost + $ip ;
##You copied this from the install script because it was not taking hold even though the commands are correct
cp /etc/xdg/openbox/rc.xml /home/$USER/.config/openbox/rc.xml
cp /etc/xdg/openbox/menu.xml /home/$USER/.config/openbox/menu.xml
cp /etc/xdg/openbox/autostart /home/$USER/.config/openbox/autostart
cp /etc/xdg/openbox/environment /home/$USER/.config/openbox/environment
sed -i 's/<name>Clearlooks<\/name>/<name>Orang<\/name>/g' /home/$USER/.config/openbox/rc.xml ;
sed -i 's/<titleLayout>NLIMC<\/titleLayout>/<titleLayout>NLM<\/titleLayout>/g' /home/$USER/.config/openbox/rc.xml ;
## Make sure proper permissions are set for ALL shared (i.e. -v) folders
## /cygdrive/c does not seem to work - must start with /c
## It seems the knime-workspace (ALL???) folder(s) must be put in the Users folder
docker run -it --rm -e DISPLAY=$DISPLAY -v $realgreatgrandparentDIR/Templates:/home/developer/Templates -v $realgreatgrandparentDIR/Scripts:/home/developer/Scripts -v $realgreatgrandparentDIR/CymeR-Workspace:/home/developer/knime-workspace:rw -v $realgreatgrandparentDIR/CymeR-Data:/home/developer/Data:rw -v /tmp/.X11-unix:/tmp/.X11-unix:rw bmuchmore/cymer && \
docker rm -f `docker ps --no-trunc -aq`

