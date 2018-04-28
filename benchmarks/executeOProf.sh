#!/bin/bash
cmd=$1
executable=$2
architecture=$3

if [ $# -eq 0 ]
  then
      echo "./ececuteOProf <interpreter> <executable> <arcitecture>"
      echo "Add interpreter (python/java etc)."
      echo "Add executable."
      echo "Add architecyure (intel/amd)."
      exit
fi

#run ophelp to get event name for branches (different per architecture)
ophelp > help.out

#INTEL
if [ $architecture = "intel" ]; then
	#miss predicted branches
	miss_pred=`cat help.out | grep -i -B 1 "number of mispredicted branches retired" | grep "_" | awk '{print substr($1, 1, length($1)-1)}'`

	#all branches
	total_branches=`cat help.out | grep -i -B 1 "number of branch instructions retired" | grep "_" | awk '{print substr($1, 1, length($1)-1)}'`
#AMD
else
	#miss predicted branches
	miss_pred=`cat help.out | grep -i -B 1 "Retired Mispredicted Branch Instructions" | grep "_" | awk '{print substr($1, 1, length($1)-1)}'`

	#all branches
	total_branches=`cat help.out | grep -i -B 1 "Retired Branch Instructions" | grep "_" | awk '{print substr($1, 1, length($1)-1)}'`
fi


echo "Architecture : "$architecture
echo "Event miss predicted branches : "$miss_pred
echo "Event all branches : "$total_branches
echo "Cmd :" $cmd

if [ ${cmd} != "java" ]; then
    # Rhino or Python
    ocount --event ${miss_pred},${total_branches} ${cmd} ${executable}
else
    # Java
    echo "JAVA"
    ocount --event ${miss_pred},${total_branches} ${cmd} -jar java/dacapo-9.12-bach.jar ${executable}
fi

rm -rf help.out
