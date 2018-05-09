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
# @brief  This script parse all the outputs metrics from the
# benchmarks
# Usage 
#      ./parseResults.sh <iteration num> <architecture>
# 
###################################################


architecture=$1     # Architecture version
iterationNum=$2     # Number of iterations

# Check input arguments
usage ()
{
        echo "./parseResults <architecture> <iteration_number>"
        echo "Add architecture (core2/haswell/ivy_bridge/nehalem/amd)."
        echo "Add number of iterations."
        exit
}

# Parse all the results to csv
parser () {

    # Directory containg benchmarks metrics for python
    RESULTDIR=updateRes/${architecture}/$1 

    # Create csv output file
    OUTPUTFILE=updateRes/${architecture}/$2
    echo -n "" > ${OUTPUTFILE}

    # Print Header row for csv files. 
    # Different header row for the state of AMD
    echo -ne "Benchmark;" >> ${OUTPUTFILE}

    if [ ${architecture} = "amd" ]
    then
        for ((i=0; i<${iterationNum}; i++))
        do
            echo -ne "TOTAL_INSTR;TOTAL_BR_RETIRED;" >> ${OUTPUTFILE}
            echo -ne "TOTAL_BR_MISS_RETIRED;TOTLA_MISS_IND_BR;" >> ${OUTPUTFILE}
        done
    else
        for ((i=0; i<${iterationNum}; i++))
        do
            echo -ne "TOTAL_INSTR;TOTAL_BR_RETIRED;" >> ${OUTPUTFILE}
            echo -ne "TOTAL_BR_MISS_RETIRED;TOTAL_BR;" >> ${OUTPUTFILE}
            echo -ne "TOTAL_MISS_PRED;TOTAL_IND_BR;TOTAL_MISS_IND_BR;" >> ${OUTPUTFILE}
            echo -ne "TOTAL_COND_BR;TOTAL_MISS_COND_BR;" >> ${OUTPUTFILE}
        done
    fi

    # Change line
    echo " " >> ${OUTPUTFILE}

    # Iterate all the results in python directory
    for f in ${RESULTDIR}/*\:0.txt
    do
        filename="${f##*/}" 
        extension="${filename%.*}"

        # File name avoiding iteration number
        fnameNoIter=`echo ${extension} | awk -F ':' '{print ($1)}'`
        benchName=`echo ${fnameNoIter} | awk -F 'out_' '{print ($2)}'`

        # Iterate all benchmarks and get brach predictions metrics
        for ((i=0; i<${iterationNum}; i++))
        do
            if [ ${i} -eq 0 ]; then
                echo -ne ${benchName} ";" >> ${OUTPUTFILE}
            fi

            # Grep the line which contains the string "% time counted" and then
            # get 9 lines(intel archs) or 4 lines(amd) after this line and get
            # the 2nd column containing the metrics.  Assign metrics to
            # variables as the same order in the file
            #
            # Grep output examples: --------------------- Count 297,815,131,747
            # 883,770,778 59,123,344,075 349,815,341 7,495,202,690
            # 38,440,604,214 371,647,733 43,580,826,438 302,303,658
            # ---------------------
            #

            if [ ${architecture} != "amd" ]
            then
                grepLines=$(cat ${RESULTDIR}/${fnameNoIter}\:${i}.txt \
                    | grep -A 9 "% time counted" \
                    | awk '{print$2}')

                total_instr=`echo ${grepLines} | cut -d ' ' -f2`
                miss_pred=`echo ${grepLines} | cut -d ' ' -f3`
                total_branches=`echo ${grepLines} | cut -d ' ' -f4`
                miss_indirect_br=`echo ${grepLines} | cut -d ' ' -f5`
                indirect_br=`echo ${grepLines} | cut -d ' ' -f6`
                conditional_br=`echo ${grepLines} | cut -d ' ' -f7`
                miss_conditional_br=`echo ${grepLines} | cut -d ' ' -f8`
                total_branches_retired=`echo ${grepLines} | cut -d ' ' -f9`
                total_branches_miss_retired=`echo ${grepLines} | cut -d ' ' -f10`

                echo -ne "${total_instr};${total_branches_retired};" >> ${OUTPUTFILE}
                echo -ne "${total_branches_miss_retired};" >> ${OUTPUTFILE}
                echo -ne "${total_branches};${miss_pred};" >> ${OUTPUTFILE}
                echo -ne "${indirect_br};${miss_indirect_br};" >> ${OUTPUTFILE}
                echo -ne "${conditional_br};${miss_conditional_br};" >> ${OUTPUTFILE}
            else
                grepLines=$(cat ${RESULTDIR}/${fnameNoIter}\:${i}.txt \
                    | grep -A 4 "% time counted" \
                    | awk '{print$2}')

                total_instr=`echo ${grepLines} | cut -d ' ' -f2`
                miss_indirect_br=`echo ${grepLines} | cut -d ' ' -f3`
                total_branches_retired=`echo ${grepLines} | cut -d ' ' -f4`
                total_branches_miss_retired=`echo ${grepLines} | cut -d ' ' -f5`

                echo -ne "${total_instr};${total_branches_retired};" >> ${OUTPUTFILE}
                echo -ne "${total_branches_miss_retired};" >> ${OUTPUTFILE}
                echo -ne "${miss_indirect_br};" >> ${OUTPUTFILE}
            fi
        done
        echo " " >> ${OUTPUTFILE}
    done
}

# Check input arguments
if [ $# -lt 2 ]
then
    usage
fi

# Python Results
parser pythonRes merge_pythonRes.csv

# Javascript Results
parser javascriptRes merge_javascriptRes.csv

# Java Results
parser javaRes merge_javaRes.csv

