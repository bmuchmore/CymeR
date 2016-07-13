@echo off
set current=%cd%
pushd ..
set parent=%cd%
pushd ..
set grandparent=%cd%
popd
icacls "%parent%\CymeR-Data" /grant Everyone:(OI)(CI)F
icacls "%parent%\CymeR-Data" /grant Users:(OI)(CI)F
icacls "%parent%\CymeR-Workspace" /grant Everyone:(OI)(CI)F
icacls "%parent%\CymeR-Workspace" /grant Users:(OI)(CI)F
icacls "%parent%\CymeR-Windows" /grant Everyone:(OI)(CI)F
icacls "%parent%\CymeR-Windows" /grant Users:(OI)(CI)F
echo #!/bin/bash > C:\Users\%USERNAME%\install.sh
echo DIR=^$( cd "$( dirname "${BASH_SOURCE[0]}" )" ^&^& pwd ) >> C:\Users\%USERNAME%\install.sh
echo parentDIR="$(dirname "$DIR")" >> C:\Users\%USERNAME%\install.sh
echo grandparentDIR="$(dirname "$parentDIR")" >> C:\Users\%USERNAME%\install.sh
echo greatgrandparentDIR="$(dirname "$grandparentDIR")" >> C:\Users\%USERNAME%\install.sh
echo realgreatgrandparentDIR="${greatgrandparentDIR#*/cygdrive}" >> C:\Users\%USERNAME%\install.sh
echo rm -rf /var/lock/pact ; >> C:\Users\%USERNAME%\install.sh
echo pact install xorg-server ; >> C:\Users\%USERNAME%\install.sh
echo rm -rf /var/lock/pact ; >> C:\Users\%USERNAME%\install.sh
echo pact install xinit ; >> C:\Users\%USERNAME%\install.sh
echo rm -rf /var/lock/pact ; >> C:\Users\%USERNAME%\install.sh
echo pact install xhost ; >> C:\Users\%USERNAME%\install.sh
echo rm -rf /var/lock/pact ; >> C:\Users\%USERNAME%\install.sh
echo pact install openbox ; >> C:\Users\%USERNAME%\install.sh
echo rm -rf /var/lock/pact ; >> C:\Users\%USERNAME%\install.sh
echo pact install obconf ; >> C:\Users\%USERNAME%\install.sh
echo rm -rf /var/lock/pact ; >> C:\Users\%USERNAME%\install.sh
echo pact install kde-workspace ; >> C:\Users\%USERNAME%\install.sh
echo rm -rf /var/lock/pact ; >> C:\Users\%USERNAME%\install.sh
echo curl -s https://raw.githubusercontent.com/tiangolo/babun-docker/master/setup.sh ^| source /dev/stdin ; >> C:\Users\%USERNAME%\install.sh
echo mkdir -p /home/$USER/.config/openbox >> C:\Users\%USERNAME%\install.sh
echo cp -r /etc/xdg/openbox/rc.xml /home/$USER/.config/openbox/rc.xml >> C:\Users\%USERNAME%\install.sh
echo cp -r /etc/xdg/openbox/menu.xml /home/$USER/.config/openbox/menu.xml >> C:\Users\%USERNAME%\install.sh
echo cp -r /etc/xdg/openbox/autostart /home/$USER/.config/openbox/autostart >> C:\Users\%USERNAME%\install.sh
echo cp -r /etc/xdg/openbox/environment /home/$USER/.config/openbox/environment >> C:\Users\%USERNAME%\install.sh
echo sed -i 's/^<name^>Clearlooks^<^\/name^>/^<name^>Orang^<^\/name^>/g' /home/^$USER/.config/openbox/rc.xml ; >> C:\Users\%USERNAME%\install.sh
echo sed -i 's/^<titleLayout^>NLIMC^<^\/titleLayout^>/^<titleLayout^>NLM^<^\/titleLayout^>/g' /home/^$USER/.config/openbox/rc.xml ; >> C:\Users\%USERNAME%\install.sh
echo docker-machine create --driver virtualbox cymer ;  >> C:\Users\%USERNAME%\install.shecho docker-machine start cymer ; >> C:\Users\%USERNAME%\install.sh
echo echo - >> C:\Users\%USERNAME%\install.sh
echo echo -- >> C:\Users\%USERNAME%\install.sh
echo echo --- >> C:\Users\%USERNAME%\install.sh
echo echo ---- >> C:\Users\%USERNAME%\install.sh
echo echo ----- >> C:\Users\%USERNAME%\install.sh
echo echo ------ >> C:\Users\%USERNAME%\install.sh
echo echo ------- >> C:\Users\%USERNAME%\install.sh
echo echo -------- >> C:\Users\%USERNAME%\install.sh
echo echo --------- >> C:\Users\%USERNAME%\install.sh
echo echo ---------- >> C:\Users\%USERNAME%\install.sh
echo echo You are now pulling a very large Docker Image. Do not be surprised if this takes a long time. ; >> C:\Users\%USERNAME%\install.sh
echo sleep 30 ; >> C:\Users\%USERNAME%\install.sh
echo eval "$(docker-machine env cymer)" ; >> C:\Users\%USERNAME%\install.sh
echo docker pull bmuchmore/cymer ; >> C:\Users\%USERNAME%\install.sh
echo #mv $realgreatgrandparentDIR/CymeR-Windows/Install.bat $realgreatgrandparentDIR/CymeR-Windows/BaseFiles/Install/Install.bat ; >> C:\Users\%USERNAME%\install.sh
echo echo - >> C:\Users\%USERNAME%\install.sh
echo echo -- >> C:\Users\%USERNAME%\install.sh
echo echo --- >> C:\Users\%USERNAME%\install.sh
echo echo ---- >> C:\Users\%USERNAME%\install.sh
echo echo ----- >> C:\Users\%USERNAME%\install.sh
echo echo ------ >> C:\Users\%USERNAME%\install.sh
echo echo ------- >> C:\Users\%USERNAME%\install.sh
echo echo -------- >> C:\Users\%USERNAME%\install.sh
echo echo --------- >> C:\Users\%USERNAME%\install.sh
echo echo ---------- >> C:\Users\%USERNAME%\install.sh
echo echo ^!^!^!CLOSE ME NOW - CLOSE ME NOW - CLOSE ME NOW - CLOSE ME NOW^!^!^! ; >> C:\Users\%USERNAME%\install.sh
C:\Users\Cytof2-118\.babun\cygwin\bin\dos2unix.exe C:\Users\%USERNAME%\install.sh
C:\Users\%USERNAME%\.babun\cygwin\bin\mintty.exe -h always -e /bin/bash --login -i /c/Users/%USERNAME%/install.sh
DEL C:\Users\%USERNAME%\install.sh

