#!/bin/bash
usuario=$(whoami)
if [[ $usuario != 'root' ]]; then
   echo "This script must be run as root" 
   exit 1
fi
while [ true ]
do
	clear
	echo " Hello, welcome to the fail2ban ban table"
	echo -n " Actual time: "
	date
	echo "Generant banned.log,unbanned.log i full.log"
	cat /home/david/fail2ban.log | awk -f ./genera_logs.awk
	linia=0
	secret=$(cat secret.key)
	ultima=$(tail -1 banned.log)
	while read p;
	do
		if [ $p != $ultima ]
		then 
			linia=$((linia+1))
			pais=$(echo $p | awk 'BEGIN{FS="|"}{print $1}')
			pais=$(curl ipinfo.io/$pais?token=$secret 2>/dev/null | grep country | cut -d'"' -f4)
			sed -e "${linia}s/$/|$pais/" -i banned.log
		fi
	done <banned.log
	IPs=$(tail -n 1 banned.log )
	IPs=$((IPs+1))
	tail -$IPs banned.log | grep -v Total | awk 'BEGIN{FS="|"}{print "|" $2 "|" $3 "|" $1 "|" $4 }'
	sleep 20
done
