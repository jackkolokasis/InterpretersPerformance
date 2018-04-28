#!/bin/bash
architecture=$1 
iterationNum=$2 
LOGFILE=results.log

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


echo "-----------------------------" >> ${LOGFILE} 
echo "Benchmark Testing Started    " >> ${LOGFILE} 
echo "-----------------------------" >> ${LOGFILE} 
echo " " >> ${LOGFILE} 

for ((i=0; i<${iterationNum}; i++))
do

	echo "Iteration : "${i} >> ${LOGFILE}
	echo " " >> ${LOGFILE}
	./runAllBench.sh ${architecture} ${i} >> ${LOGFILE}
done
