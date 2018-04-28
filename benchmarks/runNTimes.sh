#!/bin/bash
architecture=$1 
iterationNum=$2 

if [ $# -eq 0 ] 
then 
	echo "./runNTimes <architecture> <iteration_number>"
	echo "Add architecture (intel/amd)."
	echo "Add number of iterations."
	exit 
fi 

mkdir javascriptRes
mkdir javaRes
mkdir pythonRes

for ((i=0; i<${iterationNum}; i++))
do
	echo "iteration : "${i}
	./runAllBench.sh ${architecture} ${i}
done
