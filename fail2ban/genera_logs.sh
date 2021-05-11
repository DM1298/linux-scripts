#!/bin/bash
usuario=$(whoami)
if [[ $usuario != 'root' ]]; then
   echo "This script must be run as root" 
   exit 1
fi
clear
echo " Hello, welcome to the fail2ban ban table"
echo -n " Actual time: "
date
echo "Generant banned.log,unbanned.log i full.log"
cat $1 | awk -f ./genera_logs.awk
linia=0
secret=$(cat secret.key)
ultima=$(tail -1 banned.log)
while read p;
do
	linia=$((linia+1))
	pais=$(echo $p | awk 'BEGIN{FS="|"}{print $1}')
	pais=$(curl ipinfo.io/$pais?token=$secret 2>/dev/null | grep country | cut -d'"' -f4)
	sed -e "${linia}s/$/|$pais/" -i banned.log
done <banned.log
#cat banned.log
echo "END"
