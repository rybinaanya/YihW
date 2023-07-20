**Scripts**:

1. To download genomic and protein data from RefSeq database:

* `get_ftp_paths.sh`: get ftp paths from metadata on assemblies 

* `download_genomic_data.sh`: download translated cds sequences, genomic sequences and annotation 

* `gunzip_translated_cds.sh`: gunzip translated cds sequences

* `get_genomic_fna_headers.sh`: put in correspondence assemble_accession and refseq_chromosome_id

2. Search for YihW homologs:

* `run_phmmer_then_blastp.sh`: "phmmer + blastp" approach

* `run_nsimscan.sh` and `run_blastp_after_nsimscan.sh`: "nsimscan + blastp" approach

3. Get taxonomy information:

* `get_taxonomy.sh`

5. To get representatives sequences via MMseqs2 using linear clusterization:

* `get_representatives_mmseqs.sh`

6. To manipulate with tree and multiple sequence alignment (MSA):

* `prune_tree_MSA.py`: functions for prunning tree and MSA, removing all-gaps columns in MSA




**Requirements**:


