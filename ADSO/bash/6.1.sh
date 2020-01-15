#!/bin/bash
if [ $# -eq 1 ]; then
     home=`cat /etc/passwd | grep "^$1\>" | cut -d: -f6`
     echo $home
     echo "Espai del home: "`du -hs $home | cut -f1`
     echo "Directoris del usuari: "`cat /etc/passwd | grep "$1\>" | cut -d: -f7`
     echo "Processos actius: "`ps -F -u $1 | wc -l`
else
    echo "Has d'introduir un nom d'usuari!"
fi

