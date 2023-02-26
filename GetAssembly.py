##! /usr/bin/env python3

from tqdm import tqdm
import os
import sys
import subprocess
from bs4 import BeautifulSoup
import requests
import urllib
import pandas as pd


df=pd.read_excel("/Users/kita/Phylotree/Assembly.xlsx")


def get_assembly(df, i):
    accession=df["Accession"][i]
    file_name=df["Organism"][i]
    
    base_url="https://ftp.ncbi.nlm.nih.gov/genomes/all/"+accession[0:3]+"/"+accession[4:7]+"/"+accession[7:10]+"/"+accession[10:13]+"/"
    r=requests.get(base_url)
    soup = BeautifulSoup(r.text, "html.parser")
    elems=soup.find_all("a")
    ftp_path=elems[1].contents[0]
    assembly_path=base_url+ftp_path+ftp_path[0:-1]+"_genomic.fna.gz"

    try:     
        wgetcmd="wget -O /Users/kita/Phylotree/Genome/{}.fna.gz {}".format(file_name.replace(" ","_"), assembly_path)
        wgetcmd=subprocess.Popen(wgetcmd,shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        wgetcmd.wait()
    except:
        print("wget failed")
           
    try:  
        gunzipcmd="gunzip /Users/kita/Phylotree/Genome/{}.fna.gz".format(file_name.replace(" ","_"))
        gunzipcmd=subprocess.Popen(gunzipcmd,shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        gunzipcmd.wait()
    except:
        print("gunzip failed")
        
    return None


for i in tqdm(range(len(df))):
    get_assembly(df,i)
