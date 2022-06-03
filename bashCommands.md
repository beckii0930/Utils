# schedule a job for later:

```
echo "nohup python3 cluster2shape_makeTrain.py 5 5 &" | at now + 30 minutes
```
# submit multiple jobs in an arr to separate processes
```
declare -a All_Shapes=('Stagger-FL' 'Stagger' 'Stretch-FL' 'Stretch' 'Tilt-FL' 'Tilt')
for shape in ${All_Shapes[@]}; do
   echo $shape
   python3  PreprocessShape.py yeast $shape enriched_ &
done
```
