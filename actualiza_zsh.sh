#!/bin/zsh

clear
apt update
apt upgrade
apt full-upgrade
apt install -f
apt install --fix-missing
apt autoclean
apt autoremove

