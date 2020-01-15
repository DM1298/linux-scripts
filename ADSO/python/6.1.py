#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 27 18:50:22 2019

@author: root
"""

import sys
import subprocess


arg1=sys.argv[0]
data = []
if(len(sys.argv) > 1):
    user=sys.argv[1]
    def iterator(f):
        for line in f.readlines():
            if(line.split(":")[0] == user):
                home = line.split(":")[5]
                directoris = line.split(":")[6]
                size = subprocess.check_output(['du','-sh', home]).split()[0].decode('utf-8')
                processos = subprocess.check_output("ps -u %s | wc -l" % user, stderr=subprocess.STDOUT, shell=True)
                processos = int(processos)
        print ("Home del usuari: " + home)
        print ("Direcotris del usuari: " + directoris)
        print("Espai del home: " + size)
        print ("Processos actius del usuari: " + str(processos))
    with open("/etc/passwd","r") as f:
        iterator(f);
else:
    print("Has d'introduir un nom d'usuari")