#!/bin/bash
architecture=$1
iteration=$2

if [ $# -eq 0 ]
  then
      echo "./runAllBench <architecture>"
      echo "Add architecture (intel/amd)."
      echo "Add add iteration id (0..30)."
      exit
fi
 
for f in python/performance/benchmarks/*.py
do
    echo ${f}
    filename="${f##*/}"
    echo ${filename}
    { time ./executeOProf.sh python ${f} ${architecture} > \
	    out_${filename}_${iteration}.txt ; } 2>> out_${filename}_${iteration}.txt 
		exit
done
cd javascript/octane/     
for f in run_*.js
do
    echo ${f}
    filename="${f##*/}"
    echo ${filename}
    { time ../../executeOProf.sh rhino ${f} ${architecture} > \
        ../../out_${filename}_${iteration}.txt ; } 2>> \
   		 ../../out_${filename}_${iteration}.txt 
done
cd -

dacapoArgs=("avrora" "batik" "h2" "sunflow" "tomcat" "tradebeans" \
"tradesoap" "eclipse" "fop" "jython" "luindex" "lusearch" "pmd" \
"sunflow" "tomcat" "tradebeans" "tradesoap" "xalan")


for i in "${dacapoArgs[@]}"
do
    echo ${i}
    { time ./executeOProf.sh java ${i} ${architecture} > \
	    out_${i}_${iteration}.txt ; } 2>> out_${i}_${iteration}.txt 
done
