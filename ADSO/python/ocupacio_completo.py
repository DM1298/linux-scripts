#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct 30 20:50:31 2019

@author: root
"""
import sys
import subprocess
import os

usage1="Usage: error als parametres de --> ocupacio.sh"
usage_espai1="echo Ha de reduir el seu espai de disc"
explicacio = ("echo \"Ha de reduir el seu espai de disc\"\n" + "echo \"LOCALITZAR I ESBORRAR EL MISSATGE MODIFICAT\"\n" + "echo \"CAS DELS USUARIS AMB HOME\"\n"+
      "echo \"1. ANEM A LA NOSTRA HOME D'USUARI (cd /home/<usuari>)\"\n"+
      "echo \"2. UTILITZEM LA COMANDA $ls -la PER VEURE TOTS ELS ARXIUS OCULTS\"\n"+
      "echo \"3. OBRIM L'ARXIU <PROFILE> AMB L'EDITOR PREFERIT (AQUEST CAS nano) AMB L'INSTRUCCIO $nano .bash_profile\"\n"+
      "echo \"4. BAIXEM FINS LA LINIA ON ES TROBA EL NOSTRE MISSATGE I L'ESBORREM\"\n"+
      "echo \"5. PREMEM LES TECLES (CTRL + O) PER GUARDAR LA MODIFICACIO, FEM UN (INTRO) PER ACCEPTAR EL NOM DEL ARXIU I FINALMENT LES TECLES (CTRL + X) PER SORTIR\"\n"+
      "echo \"CAS DE L'USUARI ROOT\"\n"+
      "echo \"1. ANEM A LA NOSTRA HOME QUE EN AQUEST CAS ES SEMPRE /root ($cd /root)\"\n"
      "echo \"2. UTILITZEM LA COMANDA $ls -la PER VEURE TOTS ELS ARXIUS OCULTS\"\n"
      "echo \"3. OBRIM L'ARXIU <PROFILE> AMB L'EDITOR PREFERIT (AQUEST CAS nano) AMB L'INSTRUCCIO $nano .profile\"\n"+
      "echo \"4. BAIXEM FINS LA LINIA ON ES TROBA EL NOSTRE MISSATGE I L'ESBORREM\"\n"+
      "echo \"5. PREMEM LES TECLES (CTRL + O) PER GUARDAR LA MODIFICACIO, FEM UN (INTRO) PER ACCEPTAR EL NOM DEL ARXIU I FINALMENT LES TECLES (CTRL + X) PER SORTIR\"")
Gtobytes=1073741824
Mtobytes=1048576
Ktobytes=1024
espacioGroup=0
size_user=0
size=""
unity=""
notmodified = 0

if (len(sys.argv) == 2):
   valuein = sys.argv[1]
   #size = subprocess.check_output("echo" size "| tr -dc '0-9'", stderr=subprocess.STDOUT, shell=True)
   #unity = subprocess.check_output("echo" unity "| tr -dc 'A-Z'", stderr=subprocess.STDOUT, shell=True)
   for x in str(valuein):
       if x.isdigit():
           size += x
   for x in str(valuein):
       if x.isalpha():
           unity += x
   size = int(size)
   
   if (unity == "K"):
        size = size*Ktobytes
        #print size
   elif (unity == "G"):
        size=size*Gtobytes
        #print size
   else:
        size=size*Mtobytes
        #print size
        
    # afegiu una comanda per llegir el fitxer de password i només agafar el
    # 3camp de # nom de l'usuari
   with open("/etc/passwd","r") as f:
    for line in f.readlines():
        user = line.split(":")[0]
        home = line.split(":")[5]
        if (os.path.isdir(home) and home != "/" and home != "/proc"):
            size_user = subprocess.check_output(['du', '-bs', home]).split()[0].decode('utf-8')
            size_user = int(size_user)
            if (size_user > size):
                aux_home=home.split("/")[1]
                print str((user) + "      " + str(size_user)+"B")
                if(aux_home == "home" or home == "/root"):
                    if (aux_home == "home"):
                        fl = open (home+"/.bash_profile","a")
                        fl.write(explicacio)
                        fl.close()
                    elif (home == "/root"):
                        fl = open (home+"/.profile","a")
                        fl.write(explicacio)
                        fl.close()
            else:
                print str((user) + "      " + str(size_user)+ "B")
    
if (len(sys.argv) == 4 and sys.argv[1] == "-g"):
   groupin = sys.argv[2]
   valuein = sys.argv[3]
   for x in str(valuein):
       if x.isdigit():
           size += x
   for x in str(valuein):
       if x.isalpha():
           unity += x
   size = int(size)
   
   if (unity == "K"):
        size = size*Ktobytes
   elif (unity == "G"):
        size=size*Gtobytes
   else:
        size=size*Mtobytes

   with open("/etc/passwd","r") as g:
       for line in g.readlines():
           user = line.split(":")[0]
           home = line.split(":")[5]
           id_group = line.split(":")[3]
           with open("/etc/group", "r") as h:
               for line2 in h.readlines():
                   group_tmp = line2.split(":")[0]
                   id_tmp = line2.split(":")[2]
                   if (id_tmp == id_group):
                       group = group_tmp
                   else:
                       group = "noeselgrup"
                   if (os.path.isdir(home) and home != "/" and home != "/proc" and group == groupin):
                       size_user = subprocess.check_output(['du', '-bs', home]).split()[0].decode('utf-8')
                       size_user = int(size_user)
                       espacioGroup += size_user
                       if (size_user > size):
                           aux_home=home.split("/")[1]
                           print (str(user) + "      " + str(size_user) + "B")
                           if(aux_home == "home" or home == "/root"):
                               if (aux_home == "home"):
                                   fl = open (home+"/.bash_profile","a")
                                   fl.write(explicacio)
                                   fl.close()
                               elif (home == "/root"):
                                   fl = open (home+"/.profile","a")
                                   fl.write(explicacio)
                                   fl.close()
                       else:
                           print (str(user) + "      " + str(size_user) + "B")
       print "Total Grup    "+ str(espacioGroup) 

     
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
    

    
    
    
    
    
    
    
    

