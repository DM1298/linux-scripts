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
	cat /var/log/fail2ban.log | awk -f ./fail2ban.awk
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
	echo " _______________________________________________________________"
	echo -e "|\t\t\t\t\t\t\t\t|"
	echo -e "|   Date\t    Hora\t     IP \t  Country\t|"
	echo "|_______________________________________________________________|"
	echo -e "|\t\t\t\t\t\t\t\t|"
	tail -$IPs banned.log | grep -v Total | awk 'BEGIN{FS="|"}{    print "| " $2 "\t" $3 "\t \033[91m" $1 "\033[39m\t    " $4 "   \t|"}'
	echo "|_______________________________________________________________|"
	sleep 20
done
