#!/bin/bash
suma=0
if [ $# -eq 2 ]; then
        tiempo=$1
        nombre=$2;    
else
    echo "Has de introduir un nombre positiu i un nom de usuari"; exit 1
fi

for user in $(cat /etc/passwd | grep "$nombre" | awk -F: '{print $1}'); do
    home=`cat /etc/passwd | grep "^$user\>" | cut -d: -f6`
    if [ -d $home ]; then
        for fichero in $(find $home -type f -user $user -mtime "-$tiempo"); do
            size=$(du -bs $fichero | awk '{print $1}')
            suma=$((suma+size))
        done
        num_fich=`find $home -type f -user $user -mtime "-$tiempo" | wc -l`
    fi
    suma=$(($suma / 1048576))
    echo "$nombre ($user) $num_fich fitxers modificats que ocupen $suma M"
done