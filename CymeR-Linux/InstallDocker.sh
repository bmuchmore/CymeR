#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentDIR="$(dirname "$DIR")"

# Much taken from: https://gist.github.com/wdullaer/f1af16bd7e970389bad3

# Ask for the user password
# Script only works if sudo caches the password for a few minutes
sudo true

# Install kernel extra's to enable docker aufs support
sudo apt-get -y install linux-image-extra-$(uname -r)

# Add Docker PPA and install latest version
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-get install lxc-docker -y

# Install docker-cleanup command
cd /tmp
git clone https://gist.github.com/76b450a0c986e576e98b.git
cd 76b450a0c986e576e98b
sudo mv docker-cleanup /usr/local/bin/docker-cleanup
sudo chmod +x /usr/local/bin/docker-cleanup

##Brian: Add the user to group docker so docker can be run without sudo priviliges in the future
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo service docker restart

##Brian: Move this install file into another folder for reasons of practicality
##sudo mv $DIR/InstallDocker.sh $DIR/BaseFiles/Install/InstallDocker.sh && \

echo "*** The system will now restart in 10 seconds ***"
sudo sleep 10

##Brian: Restart the system to allow the docker changes to take place
sudo shutdown -r now



