out_xvg_fn="concat_traj_all.xvg"
out_xvg_fn="concat_traj_equilibrated.xvg"
start_index=9
end_index=18
echo '' > concat_traj2.sh
for (( i=${start_index}; i<=${end_index}; i++))
do
	k=$((i-1))
	j=$((k*2000))
	cmd="awk 'NR>=25  { print \$1+${j} \"  \" \$2}' step4_equilibration_density${i}.xvg > concat_traj_temp${i}.out" 
	echo $cmd >> concat_traj2.sh
done
chmod 777 concat_traj2.sh
./concat_traj2.sh
./concat_traj3.sh ${out_xvg_fn} ${start_index} ${end_index}
