#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov  9 18:15:21 2019

@author: root
"""
import sys
import os
import subprocess
suma=0

if(len(sys.argv) == 3):
    tiempo=sys.argv[1]
    nombre=sys.argv[2]    
else:
    print ("Has de introduir un nombre positiu i un nom de usuari")
    exit(1)

with open("/etc/passwd","r") as f:
    for line in f.readlines():
        user = line.split(":")[0]
        fullName = line.split(":")[4]
        home = line.split(":")[5]
        if (fullName == nombre and os.path.isdir(home) and home != "/" and home != "/proc"):
            s ="find " +home+" -type f -user "+ user+" -mtime -"+tiempo
            fitxers= subprocess.check_output(s, stderr=subprocess.STDOUT, shell=True)
            #print fitxers
            for i in fitxers.splitlines():
                fitxer = i
                size = subprocess.check_output(['du', '-bs', fitxer]).split()[0].decode('utf-8')
                size = int(size)
                suma+=size
            aux = "find "+ home +" -type f -user "+ user+ " -mtime -"+ tiempo+ " | wc -l"
            num_fich=subprocess.check_output(aux, stderr=subprocess.STDOUT, shell=True)
            num_fich = int(num_fich)
            suma = suma / 1048576
            print (nombre + " ("+user+") " + str(num_fich) + " fitxers modificats que ocupen "+ str(suma) + " M")
