#!/bin/bash

echo -e "\033[43;31mMarker Scan\033[0m"


dir_path="/Users/kita/Phylotree/Genome/*"
dirs=`ls ${dir_path}`


mkdir -p Phylotree/MarkerScan && cd Phylotree/MarkerScan


for dir in $dirs;
do
folder_name="`basename ${dir} .fna`"
mkdir -p "${folder_name}" && cd ${folder_name}
export AMPHORA2_home=/Users/kita/AMPHORA2
perl /Users/kita/AMPHORA2/Scripts/MarkerScanner.pl  -BACTERIA -DNA ${dir}
cd ..
find ${dir_path} -name "*.orf" | xargs rm
done
