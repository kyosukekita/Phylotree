#!/bin/bash

echo -e "\033[43;31mPhylotreeGenerator\033[0m"

echo -e "\033[43;31mDownloading Assembly file...\033[0m"
python /Users/kita/Phylotree/GetAssembly.py

#bash /Users/kita/Phylotree/MarkerScan.sh
bash /Users/kita/Phylotree/Alignment.sh
bash /Users/kita/Phylotree/TrimConcatFasttree.sh

echo "Done!"


