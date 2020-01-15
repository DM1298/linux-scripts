#!/bin/bash
total_tx=0
i=0
n_segons=0
aux=0
usage='error de parametres'
# detecció de opcions d'entrada: només son vàlids: sense paràmetres i -p
if [ $# -eq 1 ]; then
    n_segons=$1
elif [ $# -eq 0 ]; then
    aux=1
else 
    echo $usage
    exit 1
fi
while [ $i -eq 0 ]
do
    for interface in $(ls /etc/network/run/ | grep "ifstate." | cut -d. -f2); do
        tx_interface=$(cat /sys/class/net/$interface/statistics/tx_packets)
        total_tx=$((total_tx + tx_interface))
        echo $interface": "$tx_interface
    done
    echo "Total: "$total_tx
    if [ $aux == 1 ];then
        i=1
    else
       sleep $((n_segons)) 
    fi
done