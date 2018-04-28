#!/bin/bash
for f in pythonRes/
	filename="${f##*/}"
    echo "bench: "${filename}	
allBranches=`cat pythonRes/out_bm_2to3.py_0.txt | grep "BR_INST_RETIRED" | awk '{print$2}'`

missPred=`cat pythonRes/out_bm_2to3.py_0.txt | grep "BR_MISS_PRED_RETIRED" | awk '{print$2}'`


