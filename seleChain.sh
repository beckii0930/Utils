#!/bin/bash
CHAINS=$1
FILE=$2
start=0

for (( i=0; i<${#CHAINS}; i++ )); do
	
	chain="${CHAINS:$i:1}"
	if [ $start == 0 ]
	then
		start=1
		grep " ${CHAINS:$i:1} " $2 > ${FILE%%.*}_$1.pdb
	else
		grep " ${CHAINS:$i:1} " $2 >> ${FILE%%.*}_$1.pdb

	fi
done

echo "Output: ${FILE%%.*}_$1.pdb"
