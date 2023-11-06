#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 32
#SBATCH -t 5-00:00:00
#SBATCH -J trimmomatic
#SBATCH -A proj5034

source ~/.bashrc
conda activate trimmomatic

genomes=(
  "CGAF_FDSW220159412-1r_HYH2VDSX2_L3"
  "CGAF_FDSW220159412-1r_HYNCNDSX2_L4"
  "CGAM_FDSW220157897-1r_HYJYHDSX2_L2"
  "CMAF_FDSW220157896-1r_HJCYWDSX3_L1"
  "CMAF_FDSW220157896-1r_HYJY5DSX2_L3"
  "CMAM1_FDSW220159411-1r_HYH2VDSX2_L3"
)
RAW_READS="/tarafs/scratch/proj5034-AGBKU/catfish_illumina"
ILLUMINACLIP="/tarafs/data/home/hrasoara/proj5034-AGBKU/Download_BettaFish/TruSeq3-SE.fa"
mkdir -p data/trimmed_illumina
for genome in "${genomes[@]}"
do
  echo "${genome}"
  trimmomatic PE -phred33 "${RAW_READS}/${genome}_1.fq.gz" "${RAW_READS}/${genome}_2.fq.gz" \
    "data/trimmed/${genome}_1_pairend_trimmed.fq" "data/trimmed/${genome}_1_unpair.fq" \
    "data/trimmed/${genome}_2_pairend_trimmed.fq" "data/trimmed/${genome}_2_unpair.fq" \
    LEADING:3 TRAILING:3 MINLEN:100 HEADCROP:10 \
    ILLUMINACLIP:${ILLUMINACLIP}:2:30:10 SLIDINGWINDOW:4:15 -threads 32
  exit
done
