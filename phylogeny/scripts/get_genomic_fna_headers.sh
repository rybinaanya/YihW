#!/bin/bash
gz_genomes_folder=$1
output_dir=$2

# Entering a directory
cd ${gz_genomes_folder}

# Get genomic fna headers
for f in *.fna.gz; do echo ${f} $(zgrep -e '>' ${f}); done > ${output_dir}/genomic_fna_headers.txt
