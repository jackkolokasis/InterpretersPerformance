#!/bin/bash

###################################################
#
# file: boxPlotParser.sh
#
# @Author   Iacovos G. Kolokasis
#           Manos Pavlidakis
# @Version  12-05-2018
# @email    kolokasis@ics.forth.gr
#           manospavl@ics.forth.gr
#
# @brief  This script parse the results for the boxplot
# Usage 
#      ./boxPlotParser.sh
# 
###################################################

iterationNum=10     # Number of iterations

declare -a archs=("amd" "core2" "haswell" "ivy_bridge" "nehalem") 
mkdir -p compareResults/tmp
# Parse all the results to csv
parser () {
    
    # Directory containg benchmarks metrics for python
    RESULTDIR="updateRes/$3/$1"

    # Create csv output file
    OUTPUTFILE="compareResults/tmp/$2"

    # Iterate all the results in python directory
    for f in ${RESULTDIR}/*\:0.txt
    do
        filename="${f##*/}" 
        extension="${filename%.*}"

        # File name avoiding iteration number
        fnameNoIter=`echo ${extension} | awk -F ':' '{print ($1)}'`
        benchName=`echo ${fnameNoIter} | awk -F 'out_' '{print ($2)}'`

        for ((i=0; i<${iterationNum}; i++))
        do
            if [ ${i} -eq 0 ]; then
                echo ${benchName} > ${OUTPUTFILE}_${benchName}.csv
            fi

            # Grep the line which contains the string "% time counted" and then
            # get 9 lines(intel archs) or 4 lines(amd) after this line and get
            # the 2nd column containing the metrics.  Assign metrics to
            # variables as the same order in the file
            #
            # Grep output examples: --------------------- 
            # Count 297,815,131,747
            # 883,770,778 59,123,344,075 349,815,341 7,495,202,690
            # 38,440,604,214 371,647,733 43,580,826,438 302,303,658
            # ---------------------
            #

            if [ $3 != "amd" ]
            then
                grepLines=$(cat ${RESULTDIR}/${fnameNoIter}\:${i}.txt \
                    | grep -A 9 "% time counted" \
                    | awk '{print$2}')

                total_instr=`echo ${grepLines} | cut -d ' ' -f2 | sed -e 's,\,,,g'`
                miss_pred=`echo ${grepLines} | cut -d ' ' -f3 | sed -e 's,\,,,g'`
                total_branches=`echo ${grepLines} | cut -d ' ' -f4 | sed -e 's,\,,,g'`
                miss_indirect_br=`echo ${grepLines} | cut -d ' ' -f5 | sed -e 's,\,,,g'`
                indirect_br=`echo ${grepLines} | cut -d ' ' -f6 | sed -e 's,\,,,g'`
                conditional_br=`echo ${grepLines} | cut -d ' ' -f7 | sed -e 's,\,,,g'`
                miss_conditional_br=`echo ${grepLines} | cut -d ' ' -f8 | sed -e 's,\,,,g'`
                total_branches_retired=`echo ${grepLines} | cut -d ' ' -f9 | sed -e 's,\,,,g'`
                total_branches_miss_retired=`echo ${grepLines} | cut -d ' ' -f10 | sed -e 's,\,,,g'`

                # Calculation of MPKI. 
                thousand_Instr=$(echo "scale=4; ${total_instr} / 1000" | bc)
                mpki=$(echo "scale=4; ${miss_indirect_br} / ${thousand_Instr}" | bc)
                
            else
                grepLines=$(cat ${RESULTDIR}/${fnameNoIter}\:${i}.txt \
                    | grep -A 4 "% time counted" \
                    | awk '{print$2}')

                total_instr=`echo ${grepLines} | cut -d ' ' -f2 | sed -e 's,\,,,g'`
                miss_indirect_br=`echo ${grepLines} | cut -d ' ' -f3 | sed -e 's,\,,,g'`
                total_branches_retired=`echo ${grepLines} | cut -d ' ' -f4 | sed -e 's,\,,,g'`
                total_branches_miss_retired=`echo ${grepLines} | cut -d ' ' -f5 | sed -e 's,\,,,g'`

                # Calculation of MPKI. 
                thousand_Instr=$(echo "scale=4; ${total_instr} / 1000" | bc)
                mpki=$(echo "scale=4; ${miss_indirect_br} / ${thousand_Instr}" | bc)
            fi
            # Print the average 
            echo "${mpki}" >> ${OUTPUTFILE}_${benchName}.csv
        done
    done
}

for ar in "${archs[@]}"
do
    # Python Results
    parser pythonRes merge_pythonRes ${ar}
    ./merge_csv.sh boxplot python ${ar}
    rm -rf compareResults/tmp/*

    # Javascript Results
    parser javascriptRes merge_javascriptRes ${ar}
    ./merge_csv.sh boxplot javascript ${ar}
    rm -rf compareResults/tmp/*

    # Java Results
    parser javaRes merge_javaRes ${ar}
    ./merge_csv.sh boxplot java ${ar}
    rm -rf compareResults/tmp/*
done
rm -rf compareResults/tmp
