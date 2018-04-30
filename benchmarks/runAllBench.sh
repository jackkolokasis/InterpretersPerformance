#!/bin/bash
architecture=$1
iteration=$2

if [ $# -eq 0 ]
  then
      echo "./runAllBench <architecture>"
      echo "Add architecture (Skylake/Haswell/Ivy_bridge/intel/amd)."
      echo "Add add iteration id (0..30)."
      exit
fi

for f in python/performance/benchmarks/*.py
do
    filename="${f##*/}"
    echo "bench: "${filename}
    { time ./executeOProf.sh python3 ${f} ${architecture} > \
	    pythonRes/out_${filename}:${iteration}.txt ; } 2>> \
    		pythonRes/out_${filename}:${iteration}.txt
done

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

dacapoArgs=("avrora" "batik" "h2" "sunflow" "tomcat" "tradebeans" \
"tradesoap" "eclipse" "fop" "jython" "luindex" "lusearch" "pmd" \
"sunflow" "tomcat" "tradebeans" "tradesoap" "xalan")

for i in "${dacapoArgs[@]}"
do
    echo "bench: " ${i}
    { time ./executeOProf.sh java ${i} ${architecture} > \
	    javaRes/out_${i}:${iteration}.txt ; } 2>> javaRes/out_${i}:${iteration}.txt 
done

