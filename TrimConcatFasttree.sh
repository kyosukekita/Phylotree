#!/bin/bash

echo -e "\033[43;31mTrim & concat& Fasttree\033[0m"


dir_path="/Users/kita/Phylotree"
cd $dir_path

markers="dnaG frr infC nusA pgk pyrG rplA rplB rplC rplD rplE rplF rplK rplL rplM rplN rplP rplS rplT rpmA rpoB rpsB rpsC rpsE rpsI rpsJ rpsK rpsM rpsS smpB tsf"

touch used_gene.txt


for gene in $markers;
do
if [ $(grep -o -i ">" /Users/kita/Phylotree/Alignment/${gene}alignment/${gene}.fasta | wc -w) -eq 53 ]; then
echo ${gene} >> used_gene.txt
fi
done

while read line
do
gene=($line)
trimal -in /Users/kita/Phylotree/Alignment/${gene}.aln -out /Users/kita/Phylotree/Alignment/${gene}trim.aln
done < used_gene.txt


goalign concat -i /Users/kita/Phylotree/Alignment/*trim.aln -o /Users/kita/Phylotree/Alignment/concat.fasta
fasttree -lg /Users/kita/Phylotree/Alignment/concat.fasta > /Users/kita/Phylotree/result.nwk

cd