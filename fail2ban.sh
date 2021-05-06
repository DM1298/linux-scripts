#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
while [ true ]
do
	clear
	echo "Bienvenido al log de fail2ban"
	cat /var/log/fail2ban.log | awk -f ./fail2ban.awk 
	sleep 1
done
