#!/bin/bash

directory=$1
cmd=$2
ext=$3
architecture=$4

if [ $# -eq 0 ]
  then
      echo "./runAllBench <directory> <cmd> <extention> <architecture>"
      echo "Add benchmark dir path." 
      echo "Add interpreter name (pyhton/java/javascript)."
      echo "Add file extension."
      echo "Add architecture (intel/amd)."
      exit
fi

FILES=${directory}

for f in ${FILES}*.${ext}
do
    echo ${f}
    filename="${f##*/}"
    echo ${filename}
    { time ./executeOProf.sh ${cmd} ${f} ${architecture} > out_${filename}.txt ; } 2>> out_${filename}.txt 
    exit
done
