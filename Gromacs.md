#### ERRORS
1. TOO MUCH LINCS WARNING:
  Change dt to be smaller
  CHange the constraint to hbond
  Change the constraint algorithm to lincs


#### Plot energy

```
fn="2r5z_protonated"
echo "Potential" | gmx energy -f ${fn}_min1.edr -o ${fn}_min1.xvg

for i in 1 2 3
 do
         echo "Temperature" | gmx energy -f ${fn}_eq${i}.edr -o ${fn}_temp${i}.xvg
         echo "Pressure" | gmx energy -f ${fn}_eq${i}.edr -o ${fn}_pressure${i}.xvg
 done
```

#### Plot RMSF
```
printf "Calpha\n" | gmx rmsf -s 2r5z_protonated_pr1.tpr -f 2r5z_protonated_pr1.trr -n complex.ndx -o rmsf.xvg -fit
```

### Concate the 2 time series data together
```
vi concat_traj_main.sh
./concat_traj_main.sh
```

### Some PBC removing procudure that works

```
gmx_mpi trjconv -f md_0_1.trr -s md_0_1.tpr -o 4ihv.pdb -pbc nojump -center -sep -ur compact -n complex.ndx -dt 500 &
```
```
echo "5 0" | gmx trjconv -f md.xtc -s md.tpr -o nvt_trjout_first_frame.gro -pbc mol -center -e 1 -ur compact
echo "5 0" | gmx trjconv -f md.xtc -s md.tpr -o nvt_trjout_first_frame.gro -pbc mol -center -b 2000 -ur compact
```
### Concatenate Trajectory without interaction
```
# prefix for trajectories, eg 2r5y_dna_pr1, 2r5y_dna_pr2, ... etc
fn=2r5y_dna_pr

# specify the trajectory range
s=1
e=2

# make trjcat input
trjin=""
cat_fn=""
for (( i=${s}; i<${e}; i++ ))
do
	trjin+="c\n"
	cat_fn+="${fn}${i}.trr "
done
trjin+="c"
cat_fn+="${fn}${e}.trr"

# make input to be c /n c so that it continues from the previous simulation time
echo -e "$trjin" > trjcat.inp
echo "Concatenating the following: ${cat_fn}"

# trjcat
gmx_mpi trjcat -f ${cat_fn} -cat -o ${fn}${s}${e}.trr -settime < trjcat.inp

mkdir pdbs_yb
rm pdbs_yb/*
# trjconv extract pdbs for group of interest for analysis
gmx_mpi trjconv -s ${fn}${s}.tpr -sep -f ${fn}${s}${e}.trr -pbc cluster -o pdbs_yb/pr${s}${e}_.pdb -dt 100 -n complex.ndx << EOF
9
DNA
EOF

```
