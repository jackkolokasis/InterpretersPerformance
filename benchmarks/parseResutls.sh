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
# Helpful informations:
# ---------------------
#   filename=$(basename -- "$fullfile")
#   extension="${filename##*.}"
#   filename="${filename%.*}"
###################################################


iterationNum=$1     # Number of iterations
architecture=$2     # Architecture version


# Check input arguments
if [ $# -lt 2 ]
  then
      echo "./ececuteOProf <interpreter> <executable> <arcitecture>"
      echo "Add iteration number."
      echo "Add architecture (intel/amd)."
      exit
fi

ophelp > help.out

# INTEL
# Skylake + Haswell + Ivy bridge
if [ $architecture = "skylake" ] || [ $architecture = "haswell" ] || [ $architecture = "ivy_bridge" ]
then
	echo " " $architecture
	#miss predicted branches
	miss_pred="br_misp_retired"

	#all branches
	total_branches="br_inst_retired"

# Nehalem
elif [ $architecture = "nehalem" ]
then
	echo " " $architecture
	#miss predicted branches
	miss_pred="BR_MISS_PRED_RETIRED"

	#all branches
	total_branches="BR_INST_RETIRED"

# AMD
elif [ $architecture = "amd" ]
then
	#miss predicted branches
	miss_pred=`cat help.out | grep -i -B 1 "Retired Mispredicted Branch Instructions" | grep "_" | awk '{print substr($1, 1, length($1)-1)}'`

	#all branches
	total_branches=`cat help.out | grep -i -B 1 "Retired Branch Instructions" | grep "_" | awk '{print substr($1, 1, length($1)-1)}'`

# No info for intel
else
	#miss predicted branches
	miss_pred=`cat help.out | grep -i -B 1 "number of mispredicted branches retired" | grep "_" | awk '{print substr($1, 1, length($1)-1)}'`

	#all branches
	total_branches=`cat help.out | grep -i -B 1 "number of branch instructions retired" | grep "_" | awk '{print substr($1, 1, length($1)-1)}'`

fi


#####################################
# Python Results
####################################
RESULTDIR=results/${architecture}/pythonRes

# Create output file
OUTPUTFILE=results/${architecture}/merge_pythonRes.csv
echo -n "" > ${OUTPUTFILE}

# Print Header row
echo -ne "Benchmark;" >> ${OUTPUTFILE}

for ((i=0; i<${iterationNum}; i++))
do
    echo -ne "All_Br_${i};Miss_Br_${i};" >> ${OUTPUTFILE}
done

echo " " >> ${OUTPUTFILE}

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
            echo -ne ${benchName} ";" >> ${OUTPUTFILE}
        fi
        echo -ne ${allBranches} ";" ${missPred} ";" >> ${OUTPUTFILE}
    done
    echo " " >> ${OUTPUTFILE}
done

#####################################
# Javascript Results
####################################

RESULTDIR=results/${architecture}/javascriptRes

# Create output file
OUTPUTFILE=results/${architecture}/merge_javascriptRes.csv
echo -n "" > ${OUTPUTFILE}

# Print Header row
echo -ne "Benchmark;" >> ${OUTPUTFILE}

for ((i=0; i<${iterationNum}; i++))
do
    echo -ne "All_Br_${i};Miss_Br_${i};" >> ${OUTPUTFILE}
done

echo " " >> ${OUTPUTFILE}

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
            echo -ne ${benchName} ";" >> ${OUTPUTFILE}
        fi
        echo -ne ${allBranches} ";" ${missPred} ";" >> ${OUTPUTFILE}
    done
    echo " " >> ${OUTPUTFILE}
done

#####################################
# Java Results
####################################
RESULTDIR=results/${architecture}/javaRes

# Create output file
OUTPUTFILE=results/${architecture}/merge_javaRes.csv
echo -n "" > ${OUTPUTFILE}

# Print Header row
echo -ne "Benchmark;" >> ${OUTPUTFILE}

for ((i=0; i<${iterationNum}; i++))
do
    echo -ne "All_Br_${i};Miss_Br_${i};" >> ${OUTPUTFILE}
done

echo " " >> ${OUTPUTFILE}

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
            echo -ne ${benchName} ";" >> ${OUTPUTFILE}
        fi
        echo -ne ${allBranches} ";" ${missPred} ";" >> ${OUTPUTFILE}
    done
    echo " " >> ${OUTPUTFILE}
done

# Delete help.out 
rm -rf help.out
