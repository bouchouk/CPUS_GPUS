

#!/bin/bash
                                                                                                                                                                 

#SBATCH --partition=gpu # partition name                                                                                                                                               
#SBATCH --account=MANAPY-1WABCJWE938-DEFAULT-GPU                                                                                                                                           
#SBATCH --export=NONE
#SBATCH --gres=gpu:1                       # Necessary to activate the gpu card (The number of GPUs allowed by node is 1)
#SBATCH --nodes=1
#SBATCH -n 1                               # number of cores ( max 44 per node)
#SBATCH --time=1-00:00:00                      # wall time to finish the job
#SBATCH --job-name=jupyter-lab           # job name
#SBATCH --output=jupyterlab-%j.log         # output file

# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
port=$(( 9889 ))


# print tunneling instructions jupyter-log
echo -e "
Command to create ssh tunnel:
ssh -N -f -L ${port}:${node}:${port} marwan.housni@toubkal.hpc.um6p.ma
"

# load modules or conda environments here (you can use your own conda environment)
module purge 
module load Anaconda3 CUDA/11.1.1
conda activate
# Run Jupyter lab
jupyter-lab --no-browser --port=${port} --ip=${node}