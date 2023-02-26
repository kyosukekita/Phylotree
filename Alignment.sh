#!/bin/bash

echo -e "\033[43;31mAlignment\033[0m"

dir_path="/Users/kita/Phylotree"
cd $dir_path

markers="dnaG frr infC nusA pgk pyrG rplA rplB rplC rplD rplE rplF rplK rplL rplM rplN rplP rplS rplT rpmA rpoB rpsB rpsC rpsE rpsI rpsJ rpsK rpsM rpsS smpB tsf"
for gene in $markers;
do

folder=Alignment/${gene}"alignment"
mkdir -p ${folder} && cd ${folder}


dirs=`find ${dir_path}/MarkerScan -name ${gene}.pep`
for dir in $dirs;
do
directory="`dirname $dir`"
directory="`basename $directory`"
new_file=${directory}.fasta
cp ${dir} ${new_file}
done

#fasta fileのIDを取り出す
for FILE in *.fasta;
do
awk '/^>/ {gsub(/.fasta?$/,"",FILENAME);printf(">%s\n",FILENAME);next;} {print}' $FILE > ${FILE}.fa
echo ${FILE}
done

cat *.fa > ${gene}.fasta
clustalo -t Protein -i  /Users/kita/Phylotree/${folder}/${gene}.fasta -o /Users/kita/PhyloTree/Alignment/${gene}.aln

cd ../..
done