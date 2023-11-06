#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 32
#SBATCH -t 5-00:00:00
#SBATCH -J trimmomatic
#SBATCH -A proj5034

indiv=$1

export PATH=$PATH:~/softwares/kmerfreq/kmerfreq
mkdir -p data/kmerfreq

echo "" > read_files.lib.tmp
echo "data/trimmed_illumina/${indiv}_1_pairend_trimmed.fq" >> read_files.lib.tmp
echo "data/trimmed_illumina/${indiv}_2_pairend_trimmed.fq" >> read_files.lib.tmp
kmerfreq -k 17 -t 32 -p data/kmerfreq/${indiv} read_files.lib.tmp

