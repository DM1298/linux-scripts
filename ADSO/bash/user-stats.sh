echo "Resum de logins:"

for user in `awk -F: '{print $1}' FS=":" /etc/passwd`; do
	dies=0
	hores=0
	minuts=0
	username=`cat /etc/passwd | grep "$user" | cut -d: -f1`
	for line in $(last -F $username | grep tty1 | grep - | cut -d '(' -f2 | cut -d ')' -f1 | grep '+'); do
		auxd=$line
		dia=$(echo $auxd | grep + | cut -d'+' -f1)
		diaa=${#dia}
		if [ $diaa -ne 0 ]; then
			dies=$(($dies+$dia))
		fi
	done
	for line in $(last -F $username | grep tty1 | grep - | cut -d '(' -f2 | cut -d ')' -f1); do
		auxh=$line
		hora=$(echo $auxh | cut -d'+' -f2 | cut -d ':' -f1)
		horaa=${#hora}
		if [ $horaa -ne 0 ]; then
			hores=$(($hores+$hora))
		fi
	done
	for line in $(last -F $username | grep tty1 | grep - | cut -d '(' -f2 | cut -d ')' -f1); do
		auxm=$line
		minut=$(echo $auxm | cut -d ':' -f2)
		minutt=${#minut}
		if [ $minutt -ne 0 ]; then
			minuts=${minuts#0}
			minut=${minut#0}
			minuts=$(($minuts+$minut))
		fi
	done

	minuts=$(($minuts+($hores*60)+($dies*24*60)))

	echo "Usuari " $username ": temps total del login "$minuts " min, nombre total de logins:"`last | grep "$user" | wc -l`

done
echo "Resum d'usuaris connectats:"
for user in `awk -F: '{print $1}' FS=":" /etc/passwd`; do
	username=`cat /etc/passwd | grep "$user" | cut -d: -f1`
	status=`ps aux | grep "$username" | awk 'NR>2{arr[$1]+=$3}END{for(i in arr) print arr[i]}' | head -n 1`
	loged=`last "$username" | grep 'still logged in' | wc -l`
	
	if [ "$status" != "0" ] && [ "$status" != "" ]; then
		echo "Usuari "$username": "`ps aux | grep "$user" | wc -l `" processos -> " `ps aux | awk 'NR>2{arr[$1]+=$3}END{for(i in arr) print i, arr[i]}' | grep "$user" `" % CPU"
	else
		if [ $loged -ne 0 ]; then
		echo "Usuari "$username": "`ps aux | grep "$user" | wc -l `" processos -> " `ps aux | awk 'NR>2{arr[$1]+=$3}END{for(i in arr) print arr[i]}' | grep "$user" `"0 % CPU"
		fi
	fi
done
