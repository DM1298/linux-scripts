#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Nov 10 10:03:46 2019

@author: root
"""

import sys
import subprocess
import time

total_tx=0
i=0
n_segons=0
aux=0
usage='error de parametres'
if(len(sys.argv) == 2):
    n_segons=sys.argv[1]
elif(len(sys.argv) == 1):
    aux=1
else:
    print(usage)
    exit(1)
   
while i == 0:
    linia = subprocess.check_output(['ls','/etc/network/run/']).split()
    for interface in linia:
        a = interface.split(".")
        if (len(a) != 2):#evitar error de fora de rang
            continue
        a = interface.split(".")[1] #lectura de codi més fàcil
        tx_interface=subprocess.check_output('cat /sys/class/net/' + a + '/statistics/tx_packets', stderr=subprocess.STDOUT, shell=True)
        total_tx = total_tx + int(tx_interface)
        print(a + ': ' + tx_interface)      
    print("Total: " + str(total_tx))
    
    if(aux == 1):
        i=1
    else:
        time.sleep(float(n_segons))
