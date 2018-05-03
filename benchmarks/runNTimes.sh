#!/bin/bash

######################################################################
#
# file: runNTimes.sh
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
#   ./runNTimes <architecture> <iteration_number> <python version>
#
######################################################################


architecture=$1         # Architecture version
iterationNum=$2         # Number of iterations
pythonVersion=$3        # Python version
LOGFILE=results.log     # Log file for benchmarks execution

# Check input arguments
if [ $# -lt 3 ]
then 
	echo "./runNTimes <architecture> <iteration_number>"
	echo "Add architecture (Skylake/Haswell/Ivy_bridge/intel/amd)."
	echo "Add number of iterations."
	echo "Add add python version[python3, python3.6]."
	exit 
fi

# Remove previous results
echo "Remove previous results"
rm -rf javascriptRes
rm -rf javaRes
rm -rf pythonRes
rm -rf results.log

# Create new directories for the results
echo "Create new dirs"
mkdir javascriptRes
mkdir javaRes
mkdir pythonRes

# Start benchmarks execution
echo "Start execution"
echo "-----------------------------" >> ${LOGFILE} 
echo "Benchmark Testing Started    " >> ${LOGFILE} 
echo "-----------------------------" >> ${LOGFILE} 
echo " " >> ${LOGFILE} 

# Run all benchmarks for fixed iterations times
for ((i=0; i<${iterationNum}; i++))
do
	echo "Iteration : "${i} >> ${LOGFILE}
	echo " " >> ${LOGFILE}
	./runAllBench.sh ${architecture} ${i} ${pythonVersion} >> ${LOGFILE}
done

# Create a directory for the current architecture
# Moving all results to the arch directory
echo "Move results to architecture dir..."
mkdir ${architecture}
cp -rf javascriptRes ${architecture}
cp -rf javaRes ${architecture}
cp -rf pythonRes ${architecture}

# Create a tar file with the results of the specific architecture
tar cvf ${architecture}.tar ${architecture} 

# Clear all generated directories
echo "Clear results..."
rm -rf javascriptRes
rm -rf javaRes
rm -rf pythonRes
