#!/bin/bash
architecture=$1 
iterationNum=$2 
LOGFILE=results.log

if [ $# -eq 0 ] 
then 
	echo "./runNTimes <architecture> <iteration_number>"
	echo "Add architecture (Skylake/Haswell/Ivy_bridge/intel/amd)."
	echo "Add number of iterations."
	exit 
fi 
echo "Remove previous results"
rm -rf javascriptRes
rm -rf javaRes
rm -rf pythonRes
rm -rf results.log
echo "Create new dirs"
mkdir javascriptRes
mkdir javaRes
mkdir pythonRes


echo "Start execution"
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

echo "Move results to architecture dir..."
mkdir ${architecture}
cp -rf javascriptRes ${architecture}
cp -rf javaRes ${architecture}
cp -rf pythonRes ${architecture}
tar cvf ${architecture}.tar ${architecture} 

echo "Clear results..."
rm -rf javascriptRes
rm -rf javaRes
rm -rf pythonRes
