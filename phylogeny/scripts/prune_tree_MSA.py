import copy
import sys
from Bio import AlignIO
from Bio import Phylo
from Bio import SeqIO
from Bio.Align import MultipleSeqAlignment

# Specify arguments
tree_newick = sys.argv[1]
alignment_fasta = sys.argv[2]
mmseqs2_fasta = sys.argv[3]
output_folder = sys.argv[4]


def prune_tree(tree_, recordid_remove_lst_):
    newtree = copy.deepcopy(tree_)
    for name in recordid_remove_lst_:
        newtree.prune(target=name)
    return newtree


def prune_alignment(alignment, recordid_remove_lst_):
    alignment_pruned = []
    for record in alignment:
        if record.id not in recordid_remove_lst_:
            record.description = ''
            alignment_pruned.append(record)
    return MultipleSeqAlignment(alignment_pruned)


def fix_alignment(alignment_pruned):
    alignment_fixed = alignment_pruned[:, :1]
    for pos in range(1, alignment_pruned.get_alignment_length()):
        if (len(set(alignment_pruned[:, pos])) == 1) and (list(set(alignment_pruned[:, pos]))[0] == '-'):
            pass
        else:
            alignment_fixed = alignment_fixed + alignment_pruned[:, pos:(pos+1)]
    return alignment_fixed


if __name__ == '__main__': 
    tree = Phylo.read(tree_newick, 'newick') 
    align = AlignIO.read(alignment_fasta, 'fasta')
    mmseqs2_records = [rec.id for rec in SeqIO.parse(mmseqs2_fasta, 'fasta')]
    recordid_remove_lst = [i.id for i in align if i.id not in mmseqs2_records]
    print(f'Pruning the tree {tree_newick}...')
    tree_pruned = prune_tree(tree, recordid_remove_lst)
    print(f'Tree is pruned! Starting to prune your alignment {alignment_fasta}...')
    align_pruned = prune_alignment(align, recordid_remove_lst)
    print(f'Alignment is pruned! Now fixing gaps...')
    align_fixed = fix_alignment(align_pruned)
    print('Done! Writing output to files...')
    AlignIO.write(align_fixed, mmseqs2_fasta.split('.fasta')[0] + 'mafft.fasta', 'fasta')
    print(f'Fixed alignment is written to ' + f'{output_folder}/' + mmseqs2_fasta.split('.fasta')[0] + '.mafft.fasta')
    Phylo.write(tree_pruned, mmseqs2_fasta.split('.fasta')[0] + '.fasttree',  'newick')
    print(f'Pruned tree is written to ' + f'{output_folder}/' + mmseqs2_fasta.split('.fasta')[0] + '.fasttree')
    print('I am done')
