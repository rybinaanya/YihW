import pandas as pd
import sys
from Bio import SeqIO

# Specify arguments
genomic_fna_headers = sys.argv[1]
nsimscan_file_path = sys.argv[2]
translated_cds_dir = sys.argv[3]


dict_chr_asm = {}
with open(genomic_fna_headers) as f:
    for line in f:
        assembly_asm = line.rstrip().split(' ')[0].split('_genomic')[0]
        chromosome_ids = [x.split(' ')[0] for x in line.rstrip().split('>')[1:]]
        dict_chr_asm.update(dict(zip(tuple(chromosome_ids), tuple([assembly_asm])*len(chromosome_ids))))

nsimscan30k = pd.read_csv(nsimscan_file_path, header=None, sep='\t')
nsimscan30k['assembly_asm'] = nsimscan30k[1].map(dict_chr_asm)
nsimscan30k['midpoint'] = (nsimscan30k[8] + nsimscan30k[9])/2
nsimscan30k['translated_csd_file'] = nsimscan30k['assembly_asm'].apply(lambda x: x+'_translated_cds.faa')
dict_file_midpoints = nsimscan30k.groupby('translated_csd_file').agg(
    {'midpoint': lambda x: sorted(list(x))}).T.to_dict('records')[0]

# get translated cds
records_lst = []
for file in dict_file_midpoints:
    midpoints = dict_file_midpoints[file]
    for record in SeqIO.parse(translated_cds_dir+file, 'fasta'):
        coord_lst = list(map(int, record.description.split('location=')[1].split(']')[0].lstrip(
            'complement(').lstrip('join(').rstrip(')').replace('>', '').replace('<', '').replace(',', "..").split('..'))
                         )
        start = min(coord_lst)
        end = max(coord_lst)
        for midpoint in midpoints:
            if start < midpoint < end:
                records_lst.append(record)

# Remove duplicates
seen = []
records_lst_uniq = []
# examples are in sequences.fasta
for record in records_lst:
    if record.id not in seen:
        seen.append(record.id)
        records_lst_uniq.append(record)

# writing to a fasta file
with open('/'.join(nsimscan_file_path.split('/')[:-1]) + "/nsimscan_k8_xt55_it55_30000rpq_seq_uniq.fasta", 'w') as f:
    SeqIO.write(records_lst_uniq, f, "fasta")
