#!/bin/bash -i
in_taxids_txt=$1
out_tax_reformat=$2
taxonkit_db=$3

taxonkit lineage ${in_taxids_txt} --data-dir $taxonkit_db | taxonkit reformat  -F -P -f "{k}\t{p}\t{c}\t{o}\t{f}\t{g}\t{s}\t{t}" --data-dir $taxonkit_db > ${out_tax_reformat}

