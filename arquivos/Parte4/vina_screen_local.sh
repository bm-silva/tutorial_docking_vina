#! /bin/bash

minhapasta=$(pwd)   #recebe o caminho onde se econtram os arquivos e o script
n=3                 #numero de ligantes no arquivo de ligantes
pythonsh='/programs/mgltools_x86_64Linux2_1.5.6/bin/python' #seta o python para rodar os scripts MGLTools
for (( i=1;i<=n;i++ )); do
     echo Preparando ligante $b
     $pythonsh $mglscripts'/'prepare_ligand4.py  -l  ligante$i.mol2  -U ''   #prepara cada ligante em pdbqt
done

#Faz o docking de cada um dos ligantes por vez e coloca o resultado em pastas com o nome dos ligantes
for f in ligante*.pdbqt; do
    b=`basename $f .pdbqt`
    echo Processando ligante $b
    mkdir -p $b
    vina --config triagem.txt --ligand $f --out ${b}/out.pdbqt --log ${b}/log.txt
done

