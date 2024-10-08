#!/bin/bash

SIZE=$1
FILE=$2

if [ $# -ne 2 ]
	then
		echo "ERROR"
		echo "Has d'escriure: bash determineSize.sh size file"
		exit 1
fi

FILESIZE=$(stat -c%s "$FILE")
echo 2>/dev/null || echo
echo "La mida del fitxer $FILE és $FILESIZE bytes"

if [ $SIZE -lt $FILESIZE ]
	then
		DIF=$(expr $FILESIZE - $SIZE)
		echo "El fitxer $FILE és mes gran per $DIF bytes"
		exit 2
fi
