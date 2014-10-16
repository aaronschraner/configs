#!/bin/bash

#List of compatible configs:
#
#   Universal:
#	bashrc
#	bash_aliases
#	vimrc
#
#   Specific:
#	awesome rc.lua
echo "This script installs some of Andy's configuration files directly from GitHub."
if [ -z configs ]; 
then
	git clone https://github.com/Inityx/configs.git
else
	#exit
	echo Already installed.
fi
cd configs
comeback="yes"
while [ "$comeback" == "yes" ]; do 
cat locations.cfg|grep -v "^#"|while read tg; do 
	if which "$(echo "$tg"|cut -d ':' -f 1)" > /dev/null 2>/dev/null;
	then
		echo "$tg"|cut -d ':' -f 2|sed 's/ / -> /g'
	else
		echo "$(echo "$tg"|cut -d ':' -f 1) not installed."
	fi
done
echo "Do you want to change these locations? (y/n)"
echo "Existing files will be backed up."
read yn;
if [ "$yn" == "y" ];
then
	nano locations.cfg
	comeback="yes"

elif [ "$yn" == "n" ]
then
	comeback="no"
else
	echo "Please type \"y\" or \"n\" followed by [Enter]"
fi
done
