"""
@author: root
"""
import sys
import subprocess
import os
#import glob


if (len(sys.argv) == 2):
    v = float(sys.argv[1])
    #s = "uptime | awk -F ", " '{print $4}'"
    t = subprocess.check_output("uptime | awk -F', ' '{print $4}'", stderr=subprocess.STDOUT, shell=True)
    t = float(t.replace(',','.'))
    if ( v <= t ):
        path= "/root/batch"
        dirs= os.listdir(path)
        #print files in a directori
        for file in dirs:
            os.system("/root/batch/"+file)
            #subprocess.check_output(s, stderr=subprocess.STDOUT, shell=True)
    else:
        print ("Mu cargao")
                
else:
    print ('las liao')
    exit(1)