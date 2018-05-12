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
#      ./merge_csv.sh <type>
# 
###################################################

type=$1

declare -a archs=("core2" "nehalem" "ivy_bridge" "haswell" "amd") 
declare -a names=("Core2" "Nehalem" "Ivy_Bridge" "Haswell" "Amd") 
declare -a inter=("python" "java" "javascript")

out_PATH=compareResults/inputs

if [ ${type} != "boxplot" ]
then
    # Iterate all interpreters and merge all results to one
    for j in "${inter[@]}"
    do
        paste -d ";" updateRes/${archs[0]}/merge_${j}Res.csv \
            updateRes/${archs[1]}/merge_${j}Res.csv \
            updateRes/${archs[2]}/merge_${j}Res.csv \
            updateRes/${archs[3]}/merge_${j}Res.csv \
            updateRes/${archs[4]}/merge_${j}Res.csv > .tmp2.csv

        # Remove the first line from the csv
        tail -n +2 .tmp2.csv > .tmp.csv

        echo -ne "Bench " > ${out_PATH}/${j}_allArchs_tmp.csv

        for i in "${names[@]}"
        do
            echo -ne "${i} ${i} " >> ${out_PATH}/${j}_allArchs_tmp.csv
        done

        echo "" >> ${out_PATH}/${j}_allArchs_tmp.csv

        cat .tmp.csv | sed "s,\ ,,g" \
            | awk -F';' '{print $1 " " $2 " " $3 " " $5 " " $6 " " $8 " " $9 " " $11 " " $12 " " $14 " " $15}' \
            >> ${out_PATH}/${j}_allArchs_tmp.csv

        if [ ${j} = "python" ]
        then
            head -n -11 ${out_PATH}/${j}_allArchs_tmp.csv \
                > ${out_PATH}/${j}_allArchs.csv
        else
            mv ${out_PATH}/${j}_allArchs_tmp.csv ${out_PATH}/${j}_allArchs.csv
        fi
        
        rm -rf ${out_PATH}/${j}_allArchs_tmp.csv .tmp2.csv .tmp.csv
    done
else
    interpreter=$2
    architecture=$3
    filename=boxplot_${interpreter}_${architecture}

    # Concantenate results
    paste -d " " compareResults/tmp/* > ${out_PATH}/${filename}.csv
   
    # Remove the last 11 benchmark results from python
    if [ ${interpreter} = "python" ]
    then
        awk '{NF-=11}1' < ${out_PATH}/${filename}.csv > ${out_PATH}/${filename}_tmp.csv
        
        mv ${out_PATH}/${filename}_tmp.csv ${out_PATH}/${filename}.csv
    fi
fi
