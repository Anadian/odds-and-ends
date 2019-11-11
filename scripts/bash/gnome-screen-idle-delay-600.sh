#!/bin/bash
echo 'Setting the screen to turn off after ten minutes of no input.' >> ~/gnome-screen.log;
gsettings set org.gnome.desktop.session idle-delay 600;
