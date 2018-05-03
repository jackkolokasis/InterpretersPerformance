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

architecture=$1         # Architecture version
iteration=$2            # Number of iterations
pythonversion=$3        # Python version

# Check input arguments
if [ $# -lt 3 ]
  then
      echo "./runAllBench <architecture> <iteration_number> <python version>"
      echo "Add architecture (Skylake/Haswell/Ivy_bridge/intel/amd)."
      echo "Add add iteration id (0..30)."
      echo "Add add python version[python3, python3.6]."
      exit
fi

# Run pyhton benchmarks suit
for f in python/performance/benchmarks/*.py
do
    filename="${f##*/}"
    echo "bench: "${filename}
    { time ./executeOProf.sh ${pythonversion} ${f} ${architecture} > \
	    pythonRes/out_${filename}:${iteration}.txt ; } 2>> \
    		pythonRes/out_${filename}:${iteration}.txt
done

# Run javascript benchmarks suit
cd javascript/octane/     
for f in run_*.js
do
    filename="${f##*/}"
    echo "bench: "${filename}
    { time ../../executeOProf.sh rhino ${f} ${architecture} > \
        ../../javascriptRes/out_${filename}:${iteration}.txt ; } 2>> \
   		 ../../javascriptRes/out_${filename}:${iteration}.txt 
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
	    javaRes/out_${i}:${iteration}.txt ; } 2>> javaRes/out_${i}:${iteration}.txt 
done

