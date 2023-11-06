#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 32
#SBATCH -t 5-00:00:00
#SBATCH -J jellyfish
#SBATCH -A proj5034

source ~/.bashrc
conda activate jellyfish

jellyfish count -m 17 -s 100M -t 32 -C data/merged_trimmed/illumina.fq
# Normally, the output file should be checked ว่าไปไหน