#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 32
#SBATCH -t 5-00:00:00
#SBATCH -J trimmomatic
#SBATCH -A proj5034

export PATH=$PATH:~/softwares/kmerfreq/kmerfreq
echo data/merged_trimmed/illumina.fq > read_files.lib.tmp
kmerfreq -k 17 -t 32 -p data/catfish_kmer read_files.lib.tmp