#!/bin/bash

query_genes_fasta=$1
gz_genomes_folder=$2
output_dir=$3

# Create output folder
echo "#_#_#_#_#_#_#_#_#_#_#_#_#_ Creating ${output_dir} _#_#_#_#_#_#_#_#_#_#_#"
mkdir -p ${output_dir}

# Entering a directory
echo "#_#_#_#_#_#_#_#_#_#_#_#_ Entering ${genomes_folder} _#_#_#_#_#_#_#_#_#_#"
cd ${genomes_folder}

# Cat genomes files
echo "#_#_#_#_#_#_#_#_#_#_#_#_ Concatenate *genomic.fna.gz #_#_#_#_#_#_#_#_#_#"
cat $(ls *gz) > ${output_dir}/BacRefSeq_genomes.fna.gz

# Gunzip all-genomes fasta
echo "#_#_#_#_#_#_#_#_ Gunzip ${output_dir}/BacRefSeq_genomes.fna.gz #_#_#_#_#"
gunzip ${output_dir}/BacRefSeq_genomes.fna.gz

# Run nsimscan
echo "#_#_#_#_#_#_#_#_#_#_#_#_#_ Running nsimscan #_#_#_#_#_#_#_#_#_#_#_#_#_#"
nsimscan  -v -k 8 -t 150 --it 55 --xt 55 --rpq 30000 --om M8 --maxslen 10000000 --minlen 70 --mdom ${query_fasta} ${output_dir}/BacRefSeq_genomes.fna ${output_dir}/nsimscan_k8_xt55_it55.sim
