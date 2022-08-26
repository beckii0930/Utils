out_fn=$1
start_index=$2
end_index=$3
echo 'Writing outputs to: ' ${out_fn}

echo '' > ${out_fn}
for (( i=${start_index}; i<=${end_index}; i++ ))
do
	awk '{print $1 "  "$2}' concat_traj_temp${i}.out >> ${out_fn}
	rm concat_traj_temp${i}.out
done
