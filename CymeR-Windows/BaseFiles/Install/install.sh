#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ;
parentDIR="$(dirname "$DIR")" ;
grandparentDIR="$(dirname "$parentDIR")" ;
greatgrandparentDIR="$(dirname "$grandparentDIR")" ;
realgreatgrandparentDIR="${greatgrandparentDIR#*/cygdrive}" ;
#--mirror http://mirrors.kernel.org/sourceware/cygwin/x86/ 
pact install xorg-server ;
pact install xinit ;
pact install xhost ;
pact install kde-workspace ;
pact install openbox ;
pact install obconf ;
curl -s https://raw.githubusercontent.com/tiangolo/babun-docker/master/setup.sh | source /dev/stdin ;
mkdir -p /home/$USER/.config/openbox
cp /etc/xdg/openbox/rc.xml /home/$USER/.config/openbox/rc.xml
cp /etc/xdg/openbox/menu.xml /home/$USER/.config/openbox/menu.xml
cp /etc/xdg/openbox/autostart /home/$USER/.config/openbox/autostart
cp /etc/xdg/openbox/environment /home/$USER/.config/openbox/environment
sed -i 's/<name>Clearlooks<\/name>/<name>Orang<\/name>/g' /home/$USER/.config/openbox/rc.xml ;
sed -i 's/<titleLayout>NLIMC<\/titleLayout>/<titleLayout>NLM<\/titleLayout>/g' /home/$USER/.config/openbox/rc.xml ;
docker-machine create --driver virtualbox cymer ; 
sleep 30 ;
eval "$(docker-machine env cymer)" ;
docker pull bmuchmore/cymer ;
#mv $realgreatgrandparentDIR/CymeR-Windows/Install.bat $realgreatgrandparentDIR/CymeR-Windows/BaseFiles/Install/Install.bat ;
echo ! ;
echo !! ;
echo !!! ;
echo !!!! ;
echo !!!!! ;
echo I am finished...You can close me now ;
