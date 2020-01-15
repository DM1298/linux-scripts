#!/bin/bash
p=0
usage='Usage: BadUser.sh [-p]'
# detecció de opcions d'entrada: només son vàlids: sense paràmetres i -p
if [ $# -ne 0 ]; then
    if  [ $# -eq 1 ]; then
        if [ $1 = "-p" ]; then
            p=1
        else
            echo $usage; exit 1
        fi
    else
        echo $usage; exit 1
    fi
fi

# afegiu una comanda per llegir el fitxer de password i només agafar el camp de # nom de l'usuari
for user in `awk -F: '{print $1}' /etc/passwd` ; do
    home=`cat /etc/passwd | grep "^$user\>" | cut -d: -f6`
    #echo $user
    #echo $home
    if [ -d $home ]; then
        num_fich=`find $home -type f -user $user | wc -l`
        #echo $num_fich
    else
        num_fich=0
        #echo $num_fich
    fi

    if [ $num_fich -eq 0 ] ; then
        if [ $p -eq 1 ]; then

# afegiu una comanda per detectar si l'usuari te processos en execució,
# si no te ningú la variable $user_proc ha de ser 0
            user_proc=$(($(ps -u $user | wc -l)-1))

            if [ $user_proc -eq 0 ]; then
                echo "$user"
            fi
        else
            echo "$user"
        fi
    fi
done


