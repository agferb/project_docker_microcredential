#!/bin/bash
#SBATCH --job-name=python-ml-train
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=1:00:00
#SBATCH --mem=16GB
#SBATCH --output=python-ml-train.%j.stdout
#SBATCH --error=python-ml-train.%j.stderr
###SBATCH complete missing info

# eventually load other modules
module purge
module swap cluster/doduo

echo Start Job
date

# Run image
apptainer run ml-train_01.00.sif
echo "Container runned"

# Finish
date
echo End Job

echo " "

# Creating resources report
echo "=== Report resources usage ==="
sacct -j $SLURM_JOBID  --format=jobid,partition,elapsed,state,totalcpu,maxrss,averss
