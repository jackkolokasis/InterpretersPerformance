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

for i in {1..${iterationNum}}
do
	echo ${i}
	./runAllBench.sh ${architecture} ${i}
	exit
done
