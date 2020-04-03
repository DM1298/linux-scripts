#!/bin/bash

while [ true ]
do
	clear
	sensors | grep Core | cut -d'(' -f1
	sleep 10
done
