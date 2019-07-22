#!/bin/bash

clear
apt update
apt upgrade
apt full-upgrade
apt install -f
apt install --fix-missing
apt autoclean
apt autoremove

#Instalamos:
#	Terminator
#	ZSH
#	gedit
#	midori
#	filezilla
#	nmap + zenmap
#	git
#	vlc

apt install terminator zsh gedit filezilla midori nmap zenmap git build-essential vlc
#Instalamos oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#Instalamos atom
wget https://atom.io/download/deb
mv deb atom.deb
dpkg -i atom.deb

