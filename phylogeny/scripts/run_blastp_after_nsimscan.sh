#!/bin/bash

# Specify variables
# path to fasta file with query sequences: 
query_protein_fasta=$1
# path to the translated cds sequences that correspond to nt fragements found by nsimscan: 
translated_cds_database=$2
# specify prefix for output files:
nsimscan_prefix=$3
# output directory:
output_dir=$4

# Create a directory for output
mkdir -p ${output_dir}

# Enter a working directory
cd ${output_dir}

# Build a local database 
makeblastdb -in ${translated_cds_database} -dbtype prot -out  ${nsimscan_prefix} -logfile ${nsimscan_prefix}_makeblastdb.log

# Running blastp
blastp -query ${query_protein_fasta} -db ${nsimscan_prefix} -out blastp_${nsimscan_prefix}.txt -outfmt 7 -evalue 1e-3 -num_descriptions 30000 -num_alignments 30000
