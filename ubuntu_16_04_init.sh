#!/bin/bash
sudo apt-get update
sudo apt-get install -y man-db openssl firefox clang make git tar vim less perl curl wget xz-utils exfat-utils hfsutils hfsplus hfsprogs p7zip-full gparted gimp audacity vlc ssh gnupg2 gnupg-doc gksu artha
#Docker CE
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#Boot Repair
sudo add-apt-repository ppa:yannubuntu/boot-repair
#Neovim
sudo add-apt-repository ppa:neovim-ppa/stable
#Node
sudo curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | show apt-key add -
sudo sh -c "echo deb https://deb.nodesource.com/node_9.x xenial main > /etc/apt/sources.list.d/nodesource.list"
#Dropbox
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ xenial main" >> /etc/apt/sources.list.d/dropbox.list'
#Nautilus open-as-administrator
sudo add-apt-repository ppa:noobslab/apps
#kdiction
#sudo snap refresh
#sudo snap install kdictionary

apt-get update
apt-get install docker-ce docker-ce-cli containerd.io boot-repair neovim nodejs dropbox open-as-administrator
