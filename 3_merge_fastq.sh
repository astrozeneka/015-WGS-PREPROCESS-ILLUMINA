#!/bin/bash

genomes=(
  "CGAF_FDSW220159412-1r_HYH2VDSX2_L3"
  "CGAF_FDSW220159412-1r_HYNCNDSX2_L4"
  "CGAM_FDSW220157897-1r_HYJYHDSX2_L2"
  "CMAF_FDSW220157896-1r_HJCYWDSX3_L1"
  "CMAF_FDSW220157896-1r_HYJY5DSX2_L3"
  "CMAM1_FDSW220159411-1r_HYH2VDSX2_L3"
)
mkdir -p data/merged_trimmed
echo "" > data/merged_trimmed/illumina.fq
for genome in "${genomes[@]}"
do
  cat "data/trimmed_illumina/${genome}_1_pairend_trimmed.fq" >> data/merged_trimmed/illumina.fq
  cat "data/trimmed_illumina/${genome}_2_pairend_trimmed.fq" >> data/merged_trimmed/illumina.fq
done
echo "Trimmed file merged"