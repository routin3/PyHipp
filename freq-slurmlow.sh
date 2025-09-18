#!/bin/bash

# Submit this script with: sbatch <this-filename>

#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=1   # number of CPUs for this task
#SBATCH -J "freq-slurmlow"   # job name

## /SBATCH -p general # partition (queue)
#SBATCH -o freq-slurmlow.%N.%j.out # STDOUT
#SBATCH -e freq-slurmlow.%N.%j.err # STDERR

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

import PyHipp as pyh; \
pyh.FreqSpectrum(saveLevel=1,redoLevel=1);

aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:206333089166:awsnotify --message "freqslurmlowJobDone"

