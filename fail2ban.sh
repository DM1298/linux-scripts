#!/bin/bash

while [ true ]
do
	clear
	cat /var/log/fail2ban.log | grep -v jail | grep -v JournalFilter | grep -v Flush | grep sshd | cut -f3 -d]
	sleep 1
done
#input="/var/log/fail2ban.log"
#while IFS= read -r line
#do
#	echo "$line" | grep INFO
#done < "$input"
