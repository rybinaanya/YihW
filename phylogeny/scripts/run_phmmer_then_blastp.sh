#!/bin/bash

# path to fasta file with query sequences: 
query_fasta=$1
# path to the Pfam database pfamseq: 
pfam_database=$2
# specify prefix for output files:
prefix=$3
# output directory:
output_dir=$4

# Create a directory for storing output
mkdir -p ${output_dir}

# Enter a working directory
cd ${output_dir}

# Run phmmer
echo "#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_ Starting to run phmmer #_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#"
phmmer -o ${prefix}_out.txt --tblout ${prefix}_tbl.txt  --domtblout ${prefix}_domtbl.txt ${query_fasta} ${pfam_database}
echo -e "Done\n"

# Get list of IDs of proteins found by phmmer 
echo "#_#_#_#_#_#_#_#_#_ Getting list of IDs for proteins found by phmmer #_#_#_#_#_#_#_#_#_#"
grep -v '#' ${prefix}_tbl.txt | cut -f1 -d' ' | sort | uniq > ${prefix}_ids.txt
echo -e "Done\n"

# Get sequences of proteins found by phmmer 
echo "#_#_#_#_#_#_#_#_#_#_#_#_ Getting protein sequences via esl-sfetch #_#_#_#_#_#_#_#_#_#_#"
esl-sfetch  -f ${pfam_database} ${prefix}_ids.txt > ${prefix}_seq.fasta
echo -e "Done\n"

# Build a local database for blastp
echo "#_#_#_#_#_#_#_#_#_# Creating a folder $(pwd .)/blastp_after_phmmer #_#_#_#_#_#_#_#_#_#"
mkdir -p blastp_after_phmmer
echo "#_#_#_#_#_ blastp output will be written to $(pwd .)/blastp_after_phmmer #_#_#_#_#_#_#"
echo -e "\n#_#_#_#_#_#_#_#_#_ Building a local database for blastp #_#_#_#_#_#_#_#_#_#_#_#_#"
makeblastdb -in ${prefix}_seq.fasta -dbtype prot -out  blastp_after_phmmer/${prefix} -logfile blastp_after_phmmer/${prefix}_makeblastdb.log
echo -e "Done\n"

# Running blastp
echo "#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_# Running blastp #_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#"
blastp -query ${query_fasta} -db blastp_after_phmmer/${prefix} -out blastp_after_phmmer/blastp_${prefix}.txt -outfmt 7 -evalue 1e-3 -num_descriptions 30000  -num_alignments 30000
echo -e "Done\n"
