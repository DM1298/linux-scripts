import sys
import subprocess
import os
import glob
import time

salida =  "Resum de logins:"
print salida
with open("/etc/passwd","r") as f:
    for line in f:
            horas=0
            minutos=0
            user = line.split(":") [0]
            username = line.split(":") [0]
            prenumlogs = "last | grep " + user + " | wc -l"
            numlogs = subprocess.check_output(prenumlogs,stderr=subprocess.STDOUT, shell=True)
            precons = "last -F "+username+" | grep tty1 | grep - | cut -d '(' -f2 | cut -d ')' -f1"
            cons = subprocess.check_output(precons,stderr=subprocess.STDOUT, shell=True).split(':')
            hora=1
            
            for nline in cons:
                for a in nline.split('\n'):
                    if(hora):
                        if(a==''):
                            hora=0
                        else:
                            minutos=minutos + float(a)*60
  
                        hora=0
                    else:
                        if(a==''):
                            hora=1
                        else:
                            minutos= minutos + float(a)
                        hora=1
                

            
            salida = "Usuari " + username + ": temps total del login "+ str(minutos) + " min, nombre total de logins: " + numlogs
            print salida
            
salida =  "Resum d'usuaris conectats:"
print salida
with open("/etc/passwd","r") as f:
    for line in f:
            user = line.split(":") [0]
            username = line.split(":") [0]
            prenum = "ps aux | grep " + user + " | wc -l"
            numproc = subprocess.check_output(prenum,stderr=subprocess.STDOUT, shell=True)
            preperc = " ps aux | awk 'NR>2{arr[$1]+=$3}END{for(i in arr) print i,arr[i]}' | grep " + user
            try:
                perc = subprocess.check_output(preperc,stderr=subprocess.STDOUT, shell=True)
                
                if ( " 0\n".encode('string-escape') in perc.encode('string-escape')):
                    preloged = "last "+ username + " | grep still | wc -l"
                    loged=0
                    loged = subprocess.check_output(preloged,stderr=subprocess.STDOUT, shell=True)
                    if( "0" in loged):
                        salida = ""
                    else:    
                        salida = "Usuari " + username + ": " + numproc + " processos -> " + perc + " % CPU"
                        print salida
                else:
                    salida = "Usuari " + username + ": " + numproc + " processos -> " + perc + " % CPU"
                    print salida
            except subprocess.CalledProcessError as e:
                    salida = ""