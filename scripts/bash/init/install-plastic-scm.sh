#!/bin/bash
sudo apt-get update
sudo apt-get install -y apt-transport-https
echo "deb https://www.plasticscm.com/plasticrepo/stable/ubuntu/ ./" | sudo tee /etc/apt/sources.list.d/plasticscm-stable.list
wget https://www.plasticscm.com/plasticrepo/stable/ubuntu/Release.key -O - | sudo apt-key add -
sudo apt-get update
