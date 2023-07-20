**Tools**:

* phmmer v3.1b2
* esl-sfetch vh3.1b2
* NsimScan tool v1.1.84
* FastTree v2.1.11 No SSE3
* MAFFT v7.475
* MMseqs2 v13-45111
* TaxonKit v0.8.0
* python packages: biopython, numpy, pandas, os, copy
* R packages: msa, aplot, dplyr, ggplot2, gggenes, ggtree, glue, ggmsa, gggenes, treeio, ggtext, magrittr, stats, stringr


**Scripts**:

1. To download genomic and protein data from RefSeq database:

* `get_ftp_paths.sh`: get ftp paths from metadata on assemblies 

* `download_genomic_data.sh`: download translated cds sequences, genomic sequences and annotation 

* `gunzip_translated_cds.sh`: gunzip translated cds sequences

* `get_genomic_fna_headers.sh`: put in correspondence assemble_accession and refseq_chromosome_id

2. To search for YihW homologs:

* `run_phmmer_then_blastp.sh`: "phmmer + blastp" approach

* `run_nsimscan.sh` and `run_blastp_after_nsimscan.sh`: "nsimscan + blastp" approach

3. To get taxonomy information:

* `get_taxonomy.sh`

5. To get representatives sequences via MMseqs2 using linear clusterization:

* `get_representatives_mmseqs.sh`

6. To manipulate with tree and multiple sequence alignment (MSA):

* `prune_tree_MSA.py`: functions for prunning tree and MSA, removing all-gaps columns in MSA



