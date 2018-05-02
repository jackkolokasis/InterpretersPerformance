#!/bin/bash
echo "Check python ..."
cd python/performance/benchmarks/
python3.6 bm_2to3.py 
cd -
echo "----------------"

echo "Check javascript ..." 
cd javascript/octane/
rhino run_box2d.js 
cd -
echo "----------------"

echo "Check java ..."
cd java/
java -jar dacapo-9.12-bach.jar avrora 
echo "----------------"
