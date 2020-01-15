#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct 30 20:50:31 2019

@author: root
"""
import sys
#import subprocess
import os

if (len(sys.argv) == 4):
    nom_usuari = sys.argv[1]
    directori = sys.argv[2]
    grups = sys.argv[3]
    
    os.system("useradd -m -d "+directori+" "+nom_usuari)
    os.system("usermod -a -G "+grups+" "+nom_usuari)
    #para meter los grupos con comas
    os.system("chsh -s /bin/bash "+nom_usuari)
    os.system("chown "+nom_usuari+":"+nom_usuari+" "+directori)
    os.system("chmod -R 750 "+directori)
    #lectura y ejecucion

else:
    print ("las liao, prueba otra vez")