#!/bin/bash

#directory=$1
#cmd=$2
#ext=$3
architecture=$1

dacapoArgs=("avrora" "batik" "h2" "sunflow" "tomcat" "tradebeans" \
"tradesoap" "eclipse" "fop" "jython" "luindex" "lusearch" "pmd" \
"sunflow" "tomcat" "tradebeans" "tradesoap" "xalan")

if [ $# -eq 0 ]
  then
      echo "./runAllBench <architecture>"
      echo "Add architecture (intel/amd)."
      exit
fi

for f in python/performance/benchmarks/*.py
do
    echo ${f}
    filename="${f##*/}"
    echo ${filename}
    { time ./executeOProf.sh python ${f} ${architecture} > out_${filename}.txt ; } 2>> out_${filename}.txt 
done
cd javascript/octane/     
for f in run_*.js
do
    echo ${f}
    filename="${f##*/}"
    echo ${filename}
    { time ../../executeOProf.sh rhino ${f} ${architecture} > \
        ../../out_${filename}.txt ; } 2>> ../../out_${filename}.txt 
done
cd -

for i in "${dacapoArgs[@]}"
do
    echo ${i}
    { time ./executeOProf.sh java ${i} ${architecture} > out_${i}.txt ; } 2>> out_${i}.txt 
        exit
done
