#!/bin/bash

if [ $# -ne 1 ]
	then
		echo "ERROR"
		echo "Escriu: bash $0 <Número del procés>"
    	exit 1
fi

PROCES=$1

# Calcula el temps de CPU del procés.
CPUTIME=$(ps -p $PROCES -o cputime= | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
# Calcula el temps d'execució del procés - Divideix el temps en hores, minuts i segons.
ETIME=$(ps -p $PROCES -o etime= | awk -F- '{ if (NF == 2) { split($2, t, ":"); print ($1 * 86400) + (t[1] * 3600) + (t[2] * 60) + t[3] } else { split($1, t, ":"); print (t[1] * 3600) + (t[2] * 60) + t[3] } }')

if [ -z "$CPUTIME" ] || [ -z "$ETIME" ]
	then
    		echo "No es poden obtenir les dades del procés $PROCES"
    		exit 1
fi

# Calcula el % de CPU
CPU_USAGE=$(echo "scale=2; ($CPUTIME * 100) / $ETIME" | bc)

echo "El procés $PROCES està utilitzant un $CPU_USAGE% de la CPU."
