#!/bin/bash

if [ $# -eq 1 ]; then
	`find /home -user $1 -print0 | xargs -0 tar czf 'files'$1'.tar.gz'`
    	`find / -user $1 -print0 | xargs -0 rm -rf`
	`deluser $1`
	`delgroup $1`
else
    	echo "No has entrat un usuari, o un usuari incorrecte."
	exit 1
fi

