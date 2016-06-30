sudo true
sudo apt-get remove --purge lxc-docker -y
sudo apt-get autoremove --purge -y
sudo rm -rf /var/lib/docker
