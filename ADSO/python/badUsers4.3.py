"""
Created on Sun Nov 9 12:47:22 2019

@author: root
"""
import sys
import subprocess
import os
import glob

p=0
n=0
n_d=0
last_log=0
usage1='Usage: bash_baduser42.sh [-p] or [-t]'
usage2='Usage: bash_baduser42.sh'
size=0
size = int(size)
unity=""
valuein = sys.argv[1]
if (len(sys.argv) != 0):
    if(sys.argv[1] == "-p"):
        p=1
    elif (sys.argv[1] == "-t"):
        p=2
        for x in str(sys.argv[2]):
           if x.isdigit():
               x = int(x)
               size += x
        for y in str(sys.argv[2]):
           if y.isalpha():
               unity += y
        size = int(size)
    else:
        print (usage1)
        exit(1)
else:
     print (usage2)
     exit(1) 
with open("/etc/passwd","r") as f:
    for line in f.readlines():
        size = 0
        user = line.split(":")[0]
        home = line.split(":")[5]
        if (os.path.isdir(home) and home != "/" and home != "/proc"):
            s ="find " + home + " -type f -user " + user+ " | wc -l"
            num_fich= subprocess.check_output(s, stderr=subprocess.STDOUT, shell=True)
            #print user+ " " +num_fich
        else:
            num_fich=0
        
        num_fich = int(num_fich)
        if(num_fich == 0):
            if(p == 1):
                user_proc= subprocess.check_output("ps -u %s | wc -l" % user, stderr=subprocess.STDOUT, shell=True)
                user_proc = int(user_proc)
                user_proc-=1
                if(user_proc == 0):
                    print (user)
            elif(p == 2):
                user_proc= subprocess.check_output("ps -u %s | wc -l" % user, stderr=subprocess.STDOUT, shell=True)
                user_proc = int(user_proc)
                user_proc-=1
                if(user_proc == 0):
                    if(unity == "m"):
                        size *= 30
                    s = "lastlog -u "+ user + " -t "+ str(size)
                    last_log = subprocess.check_output(s, stderr=subprocess.STDOUT, shell=True )
                    last_log = str(last_log)
                    if(last_log==""):
                        if(os.path.exists(home) and os.path.isdir(home) and home != "/" and home != "/proc"):
                            aux = "find "+ home +" -type f -user "+ user+ " -mtime "+ str(size) + " | wc -l"
                            num=subprocess.check_output(aux, stderr=subprocess.STDOUT, shell=True)
                            num = int(num)
                            if(num == 0):
                                usr="inactive user: "+user
                                print (usr)
            else:
                pot = ("---")
                print (user)