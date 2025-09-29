#!/bin/bash

# Submit this script with: sbatch <this-filename>

#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=5   # number of CPUs for this task
#SBATCH -J "waveform2"   # job name

## /SBATCH -p general # partition (queue)
#SBATCH -o waveform-slurm2.%N.%j.out # STDOUT
#SBATCH -e waveform-slurm2.%N.%j.err # STDERR

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

python3 -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
wfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*', '*mountains*'], objtype=pyh.Waveform); \
wfall.save();”

aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:206333089166:awsnotify --message "waveform2JobDone"

