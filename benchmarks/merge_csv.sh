#!/bin/bash

###################################################
#
# file: mege_csv.sh
#
# @Author   Iacovos G. Kolokasis
#           Manos Pavlidakis
# @Version  12-05-2018
# @email    kolokasis@ics.forth.gr
#           manospavl@ics.forth.gr
#
# @brief  This script merges all interpeters outputs results
# Usage 
#      ./merge_csv.sh 
# 
###################################################

echo -n "" >.tmp.csv
declare -a archs=("core2" "nehalem" "ivy_bridge" "haswell" "amd") 
declare -a names=("Core2" "Nehalem" "Ivy_Bridge" "Haswell" "Amd") 
declare -a inter=("python" "java" "javascript")

# Iterate all interpreters and merge all results to one
for j in "${inter[@]}"
do
    paste -d ";" updateRes/${archs[0]}/merge_${j}Res.csv updateRes/${archs[1]}/merge_${j}Res.csv \
        updateRes/${archs[2]}/merge_${j}Res.csv updateRes/${archs[3]}/merge_${j}Res.csv \
        updateRes/${archs[4]}/merge_${j}Res.csv > .tmp2.csv
    
    tail -n +2 .tmp2.csv > .tmp.csv

    echo -ne "Bench " > compareResults/inputs/${j}_allArchs_tmp.csv

    for i in "${names[@]}"
    do
        echo -ne "${i} ${i} " >> compareResults/inputs/${j}_allArchs_tmp.csv
    done

    echo "" >> compareResults/inputs/${j}_allArchs_tmp.csv

    cat .tmp.csv | sed "s,\ ,,g" |awk -F';' '{print $1 " " $2 " " $3 " " $5 " " $6 " " $8 " " $9 " " $11 " " $12 " " $14 " " $15}' \
        >> compareResults/inputs/${j}_allArchs_tmp.csv

    head -n -1 compareResults/inputs/${j}_allArchs_tmp.csv > compareResults/inputs/${j}_allArchs.csv

    rm -rf compareResults/inputs/${j}_allArchs_tmp.csv .tmp2.csv .tmp.csv
done
