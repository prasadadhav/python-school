#!/bin/bash -l
#SBATCH -J Jupyter_aion_psa                     # Name of the job
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -c 128                                  # Cores assigned to each tasks
#SBATCH --time=0-10:00:00
#SBATCH -p batch
#SBATCH --reservation=pyschool-day1             # Change it the second day to pyschool - day2
#SBATCH --mail-user prasad.adhav@uni.lu         # Optional if you want to be notified
#SBATCH --mail-type BEGIN,END,FAIL              # Optional if you want to be notified

source jupyter_env/bin/activate

jupyter notebook --ip $(hostname -i) --no-browser &

# The job is not failed
pid=$!

# just wait for 5s for no reason
sleep 5s

# jupyter notebook commands
jupyter notebook list
jupyter --paths
jupyter kernelspec list

echo "Enter this command on your laptop: ssh -p 8022 -NL 8888:$(hostname -i):8888 ${USER}@access-${SLURM_CLUSTER_NAME}.uni.lu " > notebook.log

# wait until we finish the job or the time runs out
wait $pid
