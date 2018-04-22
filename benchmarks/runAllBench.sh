#!/bin/bash

#directory=$1
#cmd=$2
#ext=$3
architecture=$1

if [ $# -eq 0 ]
  then
      echo "./runAllBench <architecture>"
      echo "Add architecture (intel/amd)."
      exit
fi

#for f in python/performance/*.py
#do
#    echo ${f}
#    filename="${f##*/}"
#    echo ${filename}
#    { time ./executeOProf.sh python ${f} ${architecture} > out_${filename}.txt ; } 2>> out_${filename}.txt 
#    exit
#done

cd javascript/octane/
pwd

for f in run_*.js
do
    echo ${f}
    filename="${f##*/}"
    echo ${filename}
    { time ../../executeOProf.sh rhino ${f} ${architecture} > ../../out_${filename}.txt ; } 2>> ../../out_${filename}.txt 
done

cd -
pwd
