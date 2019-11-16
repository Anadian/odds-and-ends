#!/bin/bash
if (( $# == 1 )); then
	echo "$(date --utc --iso-8601='seconds') Setting the screen to turn off after $1 seconds of no input." >> ~/gnome-screen.log;
	gsettings set org.gnome.desktop.session idle-delay $1;
else
	echo 'Error: must be exactly one argument given.';
fi
