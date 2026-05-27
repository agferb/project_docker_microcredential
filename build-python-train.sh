#!/bin/bash
#SBATCH --job-name=python-ml-train
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=1:00:00
#SBATCH --mem=16GB
#SBATCH --output=pull-from-docker.%j.stdout
#SBATCH --error=pull-from-docker.%j.stderr
#SBATCH --reservation=vibrepdata_3
###SBATCH complete missing info

# eventually load other modules
module purge
#module load Package1 Package2 Package3
module swap cluster/doduo

# go to the (current) working directory (optional, if this is the
# directory where you submitted the job)
cd /tmp
mkdir /tmp/$USER

echo Start Job
date

# Build image
APPTAINER_CACHEDIR=/tmp/ \
APPTAINER_TMPDIR=/tmp/ \
apptainer build --fakeroot /tmp/$USER/ml-train_01.00.sif \
docker://aleitocu/ml_train:01.00

mv /tmp/$USER/ml-train_01.00.sif $VSC_SCRATCH

# Sleep after built
echo "Image built, going to sleep for 1 minute"
sleep 60

# Run image
apptainer run ml-train_01.00.sif

# Finish
date
echo End Job

echo " "

# Creating resources report
echo "=== Report resources usage ==="
sacct -j $SLURM_JOBID  --format=jobid,partition,elapsed,state,totalcpu,maxrss,averss