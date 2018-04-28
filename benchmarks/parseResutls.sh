#!/bin/bash

###################################################
#
# file: parseResutls.sh
#
# @Author   Iacovos G. Kolokasis
#           Manos Pavlidakis
# @Version  28-04-2018
# @email    kolokasis@ics.forth.gr
#           manospavl@ics.forth.gr
#
# @vrief  This script parse all the outputs metrics from the
# benchmarks
# Usage ./parseResults.sh <iteration num> <architecture>
# 
# Helpful informations:
#   filename=$(basename -- "$fullfile")
#   extension="${filename##*.}"
#   filename="${filename%.*}"
###################################################


iterationNum=$1
architecture=$2

echo -n "" > pythonRes.csv
echo -n "" > javascriptRes.csv
echo -n "" > javaRes.csv

if [ $# -eq 0 ]
  then
      echo "./ececuteOProf <interpreter> <executable> <arcitecture>"
      echo "Add iteration number."
      echo "Add architecture (intel/amd)."
      exit
fi

ophelp > help.out

#INTEL
if [ $architecture = "intel" ]; then
	#miss predicted branches
	miss_pred=`cat help.out \
        | grep -i -B 1 "number of mispredicted branches retired" \
        | grep "_" \
        | awk '{print substr($1, 1, length($1)-1)}'`

	#all branches
	total_branches=`cat help.out \
        | grep -i -B 1 "number of branch instructions retired" \
        | grep "_" \
        | awk '{print substr($1, 1, length($1)-1)}'`
#AMD
else
	#miss predicted branches
	miss_pred=`cat help.out \
        | grep -i -B 1 "Retired Mispredicted Branch Instructions" \
        | grep "_" \
        | awk '{print substr($1, 1, length($1)-1)}'`

	#all branches
	total_branches=`cat help.out \
        | grep -i -B 1 "Retired Branch Instructions" \
        | grep "_" \
        | awk '{print substr($1, 1, length($1)-1)}'`
fi

#####################################
# Python Results
####################################
RESULTDIR=pythonRes

for f in ${RESULTDIR}/*\:0.txt
do
    filename="${f##*/}" 
	extension="${filename%.*}"
    #name of file without iteration num
    fnameNoIter=`echo ${extension} |awk -F ':' '{print ($1)}'`
    benchName=`echo ${fnameNoIter} |awk -F 'out_' '{print ($2)}'`
   
    # Iterate all benchmarks and get brach predictions metrics
    for ((i=0; i<${iterationNum}; i++))
    do
        allBranches=`cat ${RESULTDIR}/${fnameNoIter}\:${i}.txt \
            | grep ${total_branches} \
            | awk '{print$2}'`

        missPred=`cat ${RESULTDIR}/${fnameNoIter}\:${i}.txt \
            | grep ${miss_pred} \
            | awk '{print$2}'`

        if [ ${i} -eq 0 ]; then
            echo -ne ${benchName} " " >> ${RESULTDIR}.csv
        fi
        echo -ne ${allBranches} " " ${missPred} " " >> ${RESULTDIR}.csv
    done
    echo " " >> ${RESULTDIR}.csv
done

#####################################
# Javascript Results
####################################
RESULTDIR=javascriptRes

for f in ${RESULTDIR}/*\:0.txt
do
    filename="${f##*/}" 
	extension="${filename%.*}"
    #name of file without iteration num
    fnameNoIter=`echo ${extension} |awk -F ':' '{print ($1)}'`
    benchName=`echo ${fnameNoIter} |awk -F 'out_' '{print ($2)}'`
   
    # Iterate all benchmarks and get brach predictions metrics
    for ((i=0; i<${iterationNum}; i++))
    do
        allBranches=`cat ${RESULTDIR}/${fnameNoIter}\:${i}.txt \
            | grep ${total_branches} \
            | awk '{print$2}'`

        missPred=`cat ${RESULTDIR}/${fnameNoIter}\:${i}.txt \
            | grep ${miss_pred} \
            | awk '{print$2}'`

        if [ ${i} -eq 0 ]; then
            echo -ne ${benchName} " " >> ${RESULTDIR}.csv
        fi
        echo -ne ${allBranches} " " ${missPred} " " >> ${RESULTDIR}.csv
    done
    echo " " >> ${RESULTDIR}.csv
done

#####################################
# Java Results
####################################
RESULTDIR=javaRes

for f in ${RESULTDIR}/*\:0.txt
do
    filename="${f##*/}" 
	extension="${filename%.*}"
    #name of file without iteration num
    fnameNoIter=`echo ${extension} |awk -F ':' '{print ($1)}'`
    benchName=`echo ${fnameNoIter} |awk -F 'out_' '{print ($2)}'`
   
    # Iterate all benchmarks and get brach predictions metrics
    for ((i=0; i<${iterationNum}; i++))
    do
        allBranches=`cat ${RESULTDIR}/${fnameNoIter}\:${i}.txt \
            | grep ${total_branches} \
            | awk '{print$2}'`

        missPred=`cat ${RESULTDIR}/${fnameNoIter}\:${i}.txt \
            | grep ${miss_pred} \
            | awk '{print$2}'`

        if [ ${i} -eq 0 ]; then
            echo -ne ${benchName} " " >> ${RESULTDIR}.csv
        fi
        echo -ne ${allBranches} " " ${missPred} " " >> ${RESULTDIR}.csv
    done
    echo " " >> ${RESULTDIR}.csv
done

# Delete help.out 
rm -rf help.out
