## conda is an enviroment manager for Python packages. Here, I show how to run jobs with GPU using conda.

### init an environment to run GPU
```
conda init bash
conda create -n gpuenv
```
### Rename/clone an existing env
```
conda create --name new_env --clone old_env 
conda remove --name old_env --all
```
### activate an env from conda
```
. ~/.bashrc
conda activate gpuenv
conda deactivate 
```
### download package with specific version 
```
conda install scipy=1.1.0 theano=1.0.3 keras=2.2.4 
```
### Example packages for gpuenv that I need. You can install packages needed for your application.
```
conda install -c conda-forge aesara-theano-fallback 
conda install -c conda-forge scikit-learn keras pandas h5py matplotlib cudatoolkit cudnn tensorflow-gpu
```
### Check list of packages
```
conda env list
```

### salloc for testing
```
salloc --time=2:00:00 --cpus-per-task=8 --mem=16GB --account=<project_ID>
```
### load usc modules
```
module load usc
module load anaconda3
eval "$(conda shell.bash hook)"
```
#### IMPORTANT: you need to activate your GPU environment (gpuenv) before you can use GPU on your job in cluster!!
#### Example slurm bash file to run with conda on gpu:
#### This example submit a machine learning training file train.py and requests 2 GPU nodes.
```
#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --time=1:00:00
#SBATCH --mem=64GB
#SBATCH --output=train.out
#SBATCH --partition="your gpu node partition"
#SBATCH --mail-user="your email to notify start/end"
. ~/.bashrc
conda activate gpuenv
module load usc
module load cuda/10.1.243
python3 train.py
```
#### Example bash to run with conda on cpu:
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=1:00:00
#SBATCH --account=<project_ID>
module purge
eval "$(conda shell.bash hook)"
conda activate myenv
python script.py
```

### Add local environment to Jupyter notebook using ipykernel
```
pip install --user ipykernel
```
### Activate the env before starting jupyter notebook
```
source activate myenv
python -m ipykernel install --user --name=myenv
```

# TO install specific compiler versions: 
1. GO TO https://anaconda.org/ and find the gcc version you want, click into it and follow the gcc install command
2. Find the conda env path:
```
conda create -n 
```
This will output the env location
3. link the sedired gcc executable to gcc so conda finds it
```
ln -s /home1/yibeijia/.conda/envs/curves_env/bin/x86_64-conda_cos6-linux-gnu-gcc /home1/yibeijia/.conda/envs/curves_env/bin/gcc
```
4. Restart terminal and check version with
```
gcc -v
```

# To Open JUpyter Notebook from cluster:

```
jupyter notebook --no-browser --port=8080
ssh -L 8080:localhost:8080 usename@discovery1.usc.edu
```

on the browser, go to link shown by jupter notebook at the end of output, like
http://localhost:8889/?token=d76d63f347c52979a1e7c2dbab8dd5c247aca4bf11ae51a5
