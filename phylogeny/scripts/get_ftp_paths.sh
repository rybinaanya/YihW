#!/bin/bash
assembly_stat_file=$1
output_dir=$2

# Create a directory
mkdir -p $output_dir

# List the FTP path (column 20) for the assemblies of interest, 
# in this case those that have "Complete Genome" assembly_level (column 12) 
# and "latest" version_status (column 11)
echo "Getting List of FTP paths for the assemblies of interest"
awk -F "\t" '$12=="Complete Genome" && $11=="latest"{print $20}' ${assembly_stat_file}  > ${output_dir}/ftpdirpaths

# Append the filename of interest, 
# in this case "*_genomic.gff.gz" to the FTP directory names. 
echo "Appending _genomic.gff.gz to FTP paths"
awk 'BEGIN{FS=OFS="/";filesuffix="genomic.gff.gz"}{ftpdir=$0;asm=$10;file=asm"_"filesuffix;print ftpdir,file}' ${output_dir}/ftpdirpaths > ${output_dir}/ftppaths_gff

# Append translated_cds.faa.gz 
echo "Appending _translated_cds.faa.gz to FTP paths"
awk 'BEGIN{FS=OFS="/";filesuffix="translated_cds.faa.gz"}{ftpdir=$0;asm=$10;file=asm"_"filesuffix;print ftpdir,file}' ${output_dir}/ftpdirpaths > ${output_dir}/ftppaths_translated_cds

# Append genomic.fna.gz 
echo "Appending _genomic.fna.gz to FTP paths"
awk 'BEGIN{FS=OFS="/";filesuffix="genomic.fna.gz"}{ftpdir=$0;asm=$10;file=asm"_"filesuffix;print ftpdir,file}' ${output_dir}/ftpdirpaths > ${output_dir}/ftppaths_genomic_fna
