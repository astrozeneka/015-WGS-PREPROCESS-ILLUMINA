#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 32
#SBATCH -t 24:00:00
#SBATCH -J 301_fastqc_trimmed
#SBATCH -A proj5034

module purge
source ~/.bashrc
conda activate fastqc

genomes=(
  "CGAF_FDSW220159412-1r_HYH2VDSX2_L3_1"
  "CGAF_FDSW220159412-1r_HYH2VDSX2_L3_2"
  "CGAF_FDSW220159412-1r_HYNCNDSX2_L4_1"
  "CGAF_FDSW220159412-1r_HYNCNDSX2_L4_2"
  "CGAM_FDSW220157897-1r_HYJYHDSX2_L2_1"
  "CGAM_FDSW220157897-1r_HYJYHDSX2_L2_2"
  "CMAF_FDSW220157896-1r_HJCYWDSX3_L1_1"
  "CMAF_FDSW220157896-1r_HJCYWDSX3_L1_2"
  "CMAF_FDSW220157896-1r_HYJY5DSX2_L3_1"
  "CMAF_FDSW220157896-1r_HYJY5DSX2_L3_2"
  "CMAM1_FDSW220159411-1r_HYH2VDSX2_L3_1"
  "CMAM1_FDSW220159411-1r_HYH2VDSX2_L3_2"
)
RAW_READS="/tarafs/scratch/proj5034-AGBKU/catfish_illumina"
mkdir -p data/qc_illumina
for genome in "${genomes[@]}"
do
  echo "Fastqc on ${genome}"
  fastqc -t 32 -o "data/qc_illumina/" -f fastq "${RAW_READS}/${genome}.fq.gz"
done
echo "Fastqc done"