#!/bin/bash
sudo apt-get update
sudo apt-get install -y man-db openssl firefox clang make git tar vim less perl curl wget xz-utils exfat-utils p7zip-full gparted gimp audacity vlc ssh
sudo add-apt-repository ppa:yannubuntu/boot-repair
#Neovim
sudo add-apt-repository ppa:neovim-ppa/stable
#Node
sudo curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | show apt-key add -
sudo sh -c "echo deb https://deb.nodesource.com/node_9.x xenial main > /etc/apt/sources.list.d/nodesource.list"
#Dropbox
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ xenial main" >> /etc/apt/sources.list.d/dropbox.list'
#kdiction
sudo snap refresh
sudo snap install kdictionary

apt-get update
apt-get install boot-repair neovim nodejs dropbox
