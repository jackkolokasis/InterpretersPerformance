#!/bin/bash

######################################################################
#
# file: runAllBench.sh
#
# @Author   Iacovos G. Kolokasis
#           Emmanouil Pavlidakis
# @Version  03-05-2018
# @email    kolokasis@ics.forth.gr
#           manospavl@ics.forth.gr
#
# @brief    This script runs all the bencmarks suits 
# for the interpreters on bear metal architectures.
# 
# Usage 
#   ./runAllBench <architecture> <iteration_number> <python version>
#
######################################################################

architecture=$1			# Architecture version
iteration=$2			# Number of iterations
pythonversion="python3.6"	# Python version

# Check input arguments
if [ $# -lt 2 ]
  then
      echo "./runAllBench <architecture> <iteration_number>"
      echo "Add architecture (core2/haswell/ivy_bridge/nehalem/amd)."
      echo "Add iteration count (0..30)."
      exit
fi
## Run pyhton benchmarks suit
#for f in python/performance/benchmarks/*.py
#do
#    filename="${f##*/}"
#    echo "bench: "${filename}
#    { time ./executeOProf.sh ${pythonversion} ${f} ${architecture} > \
#	    ${architecture}/pythonRes/out_${filename}:${iteration}.txt ; } 2>> \
#    		${architecture}/pythonRes/out_${filename}:${iteration}.txt
#done
# Run javascript benchmarks suite
cd javascript/octane/     
for f in run_*.js
do
    filename="${f##*/}"
    echo "bench: "${filename}
    { time ../../executeOProf.sh rhino ${f} ${architecture} > \
        ../../${architecture}/javascriptRes/out_${filename}:${iteration}.txt ; } 2>> \
	../../${architecture}/javascriptRes/out_${filename}:${iteration}.txt
done
cd -

# Run java benchmarks suit
dacapoArgs=("avrora" "batik" "h2" "sunflow" "tomcat" "tradebeans" \
"tradesoap" "eclipse" "fop" "jython" "luindex" "lusearch" "pmd" \
"sunflow" "tomcat" "tradebeans" "tradesoap" "xalan")

for i in "${dacapoArgs[@]}"
do
    echo "bench: " ${i}
    { time ./executeOProf.sh java ${i} ${architecture} > \
	    ${architecture}/javaRes/out_${i}:${iteration}.txt ; } 2>> ${architecture}/javaRes/out_${i}:${iteration}.txt 

done

