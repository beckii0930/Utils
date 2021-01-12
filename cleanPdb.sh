#!/bin/sh
for pdbfile in *.pdb
do
	echo "cleaning $pdbfile..."
	grep ^ATOM $pdbfile > ${pdbfile%.pdb}.clean.pdb
done
