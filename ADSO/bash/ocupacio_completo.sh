#!/bin/bash
usage1='Usage: error als parametres de --> ocupacio.sh'
Gtobytes=1073741824
Mtobytes=1048576
Ktobytes=1024
espacioGroup=0
if [ $# -eq 1 ]; then
   size=$(echo $1 | tr -dc '0-9')
   unity=$(echo $1 | tr -dc 'A-Z')
   
   if [ $unity=="K" ]; then
        size="$((size*Ktobytes))"
   elif [ $unity=="G" ]; then
        size="$((size*Gtobytes))"
   else
        size="$((size*Mtobytes))"
   fi
   
    for user in $(cat /etc/passwd | cut -d : -f1); do
        home=`cat /etc/passwd | grep "^$user\>" | cut -d: -f6`
        if [ -d $home ] && [ $home != "/" ] && [ $home != "/proc" ]; then
            size_user=$(du -bs $home | cut -f1)
            if [ $size_user -gt $size ]; then
                echo "$user      $size_user B"
                bool_home=$(echo $home | cut -d/ -f2)
                if [ $bool_home == "home" ] || [ $home=="/root" ]; then
                    if [ $bool_home == "home" ]; then
                        echo "echo \"tienes que reducir el espacio de disco\"" >> "$home/.bashrc"
                        echo "echo \"1. ANEM A LA NOSTRA HOME QUE EN AQUEST CAS ES SEMPRE $home (cd $home)\"" >> "$home/.bashrc"
                        echo "echo \"2. UTILITZEM LA COMANDA ls -la PER VEURE TOTS ELS ARXIUS OCULTS\"" >> "$home/.bashrc"
                        echo "echo \"3. OBRIM L'ARXIU \"bashrc\" AMB L'EDITOR PREFERIT (AQUEST CAS nano)\"" >> "$home/.bashrc"
                        echo "echo \"4. AMB L'INSTRUCCIO nano .bashrc\"" >> "$home/.bashrc"
                        echo "echo \"5. BAIXEM FINS LA LINIA ON ES TROBA EL NOSTRE MISSATGE I L'ESBORREM\"" >> "$home/.bashrc"
                        echo "echo \"6. PREMEM LES TECLES (CTRL + O) PER GUARDAR LA MODIFICACIO, FEM UN (INTRO) PER ACCEPTAR EL NOM DEL ARXIU I FINALMENT LES TECLES (CTRL + X) PER SORTIR\"" >> "$home/.bashrc"
                    elif [ $home == "/root" ]; then
                        echo "echo \"tienes que reducir el espacio de disco\"" >> "$home/.bashrc"
                        echo "echo \"1. ANEM A LA NOSTRA HOME QUE EN AQUEST CAS ES SEMPRE /root (cd /root)\"" >> "$home/.bashrc"
                        echo "echo \"2. UTILITZEM LA COMANDA ls -la PER VEURE TOTS ELS ARXIUS OCULTS\"" >> "$home/.bashrc"
                        echo "echo \"3. OBRIM L'ARXIU \"bashrc\" AMB L'EDITOR PREFERIT (AQUEST CAS nano)\"" >> "$home/.bashrc"
                        echo "echo \"4. AMB L'INSTRUCCIO nano .bashrc\"" >> "$home/.bashrc"
                        echo "echo \"5. BAIXEM FINS LA LINIA ON ES TROBA EL NOSTRE MISSATGE I L'ESBORREM\"" >> "$home/.bashrc"
                        echo "echo \"6. PREMEM LES TECLES (CTRL + O) PER GUARDAR LA MODIFICACIO, FEM UN (INTRO) PER ACCEPTAR EL NOM DEL ARXIU I FINALMENT LES TECLES (CTRL + X) PER SORTIR\"" >> "$home/.bashrc" 
                    fi
                fi
            else
                echo "$user      $size_user B"

            fi
        fi
    done
   
elif [ $# -gt 1 ] && [ $1 == "-g" ]; then
   size=$(echo $3 | tr -dc '0-9')
   unity=$(echo $3 | tr -dc 'A-Z')
   
   if [ $unity=="K" ]; then
        size="$((size*Ktobytes))"
   elif [ $unity=="G" ]; then
        size="$((size*Gtobytes))"
   else
        size="$((size*Mtobytes))"
   fi     
        
    for user in $(cat /etc/passwd | cut -d : -f1); do
        id_group=`cat /etc/passwd | grep "^$user\>" | cut -d: -f4`
        group=`cat /etc/group | grep ":$id_group:" | cut -d: -f1`
        home=`cat /etc/passwd | grep "^$user\>" | cut -d: -f6`
        if [ -d $home ] && [ "$group" == "$2" ]; then
            if [ $home != "/" ] && [ $home != "/proc" ]; then
                size_user=$(du -bs $home | cut -f1)
                #echo "$user  $(du -hs $home | cut -f1)"
                espacioGroup="$((espacioGroup+size_user))"
                if [ $size_user -gt $size ]; then
                    echo "$user      $size_user B"
                    bool_home=$(echo $home | cut -d/ -f2)
                    if [ $bool_home == "home" ] || [ $home=="/root" ]; then
                        if [ $bool_home == "home" ]; then
                            echo "echo \"Superas el espacio maximo de tu grupo\"" >> "$home/.bashrc"
                            echo "echo \"1. ANEM A LA NOSTRA HOME QUE EN AQUEST CAS ES SEMPRE $home (cd $home)\"" >> "$home/.bashrc"
                            echo "echo \"2. UTILITZEM LA COMANDA ls -la PER VEURE TOTS ELS ARXIUS OCULTS\"" >> "$home/.bashrc"
                            echo "echo \"3. OBRIM L'ARXIU \"bashrc\" AMB L'EDITOR PREFERIT (AQUEST CAS nano)\"" >> "$home/.bashrc"
                            echo "echo \"4. AMB L'INSTRUCCIO nano .bashrc\"" >> "$home/.bashrc"
                            echo "echo \"5. BAIXEM FINS LA LINIA ON ES TROBA EL NOSTRE MISSATGE I L'ESBORREM\"" >> "$home/.bashrc"
                            echo "echo \"6. PREMEM LES TECLES (CTRL + O) PER GUARDAR LA MODIFICACIO, FEM UN (INTRO) PER ACCEPTAR EL NOM DEL ARXIU I FINALMENT LES TECLES (CTRL + X) PER SORTIR\"" >> "$home/.bashrc"
                        elif [ $home == "/root" ]; then
                            echo "echo \"Superas el espacio maximo de tu grupo\"" >> "$home/.bashrc"
                            echo "echo \"1. ANEM A LA NOSTRA HOME QUE EN AQUEST CAS ES SEMPRE /root (cd /root)\"" >> "$home/.bashrc"
                            echo "echo \"2. UTILITZEM LA COMANDA ls -la PER VEURE TOTS ELS ARXIUS OCULTS\"" >> "$home/.bashrc"
                            echo "echo \"3. OBRIM L'ARXIU \"bashrc\" AMB L'EDITOR PREFERIT (AQUEST CAS nano)\"" >> "$home/.bashrc"
                            echo "echo \"4. AMB L'INSTRUCCIO nano .bashrc\"" >> "$home/.bashrc"
                            echo "echo \"5. BAIXEM FINS LA LINIA ON ES TROBA EL NOSTRE MISSATGE I L'ESBORREM\"" >> "$home/.bashrc"
                            echo "echo \"6. PREMEM LES TECLES (CTRL + O) PER GUARDAR LA MODIFICACIO, FEM UN (INTRO) PER ACCEPTAR EL NOM DEL ARXIU I FINALMENT LES TECLES (CTRL + X) PER SORTIR\"" >> "$home/.bashrc"
                        fi
                    fi
                else
                   echo "$user     $size_user B" 
                fi
            fi
        fi
    done    
    echo "totalGroup      $espacioGroup  B"           
fi