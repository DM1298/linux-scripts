#!/bin/bash

clear
apt update
apt upgrade
apt full-upgrade
apt install -f
apt install --fix-missing
apt autoclean
apt autoremove

#Instalacion basica:
#	Terminator
#	ZSH
#	gedit
#	filezilla
#	git
#	vlc
#	synaptic
apt install terminator zsh gedit filezilla git build-essential vlc synaptic

#Instalacion redes
#
#	nmap + zenmap
#	wireshark
#apt install nmap zenmap wireshark 

#Instalacion dibujo
#apt install gimp inkscape


#Instalamos oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
wget https://raw.githubusercontent.com/DM1298/dotfiles/master/zshrc
mv zshrc ~/.zshrc
rm zshrc


#Instalamos atom
wget https://atom.io/download/deb
mv deb atom.deb
dpkg -i atom.deb
rm atom.deb

