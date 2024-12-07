#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=56
#SBATCH -p compute
#SBATCH -A MANAPY-UM6P-ST-MSDA-1WABCJWE938-DEFAULT-CPU
#SBATCH --time=1-00:00:00 
#SBATCH --job-name test2
#SBATCH --output /home/houssam.bouchouk/lustre/manapy-um6p-st-msda-1wabcjwe938/users/houssam.bouchouk/cpu%j.log
# Load modules
source ~/.bashrc

module load Anaconda3
conda activate 
# Final command
node=$(hostname -s)
port="8898"

# print tunneling instructions jupyter-log
echo -e "
Command to create ssh tunnel:
ssh -N -f -L ${port}:${node}:${port} houssam.bouchouk@toubkal.hpc.um6p.ma
"

# Final command
cd /home/houssam.bouchouk/lustre/manapy-um6p-st-msda-1wabcjwe938/users/houssam.bouchouk
jupyter-lab --no-browser --port=${port} --ip=${node}




