#!/bin/bash
in_fasta=$1
output_folder=$2
fasta_name=${in_fasta%.*}

mkdir -p ${output_folder}

mmseqs createdb ${in_fasta} ${output_folder}/${fasta_name}

mmseqs linclust ${output_folder}/${fasta_name} ${output_folder}/${fasta_name}_clu ${output_folder}/tmp

mmseqs createsubdb ${output_folder}/${fasta_name}_clu ${output_folder}/${fasta_name} ${output_folder}/${fasta_name}_clu_rep

mmseqs convert2fasta ${output_folder}/${fasta_name}_clu_rep ${output_folder}/${fasta_name}_clu_rep.fasta

