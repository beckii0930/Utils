
#awk '{if (NR == 1) { printf "%s", substr($4,2,1)} else { if ($6 > prev) { printf "%s", substr($4,2,1); prev=$6 }}}' pdb/1KX5_atomistic_DNA.pdb
awk '{if (NR == 1) { printf "%s", substr($4,2,1)} else { if ($6 != prev) { printf "%s", substr($4,2,1); prev=$6 }}}' $1
