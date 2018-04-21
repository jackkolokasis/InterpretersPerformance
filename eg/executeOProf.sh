#!/bin/bash
executable=$1
architecture=$2

if [ $# -eq 0 ]
  then
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

ocount --event ${miss_pred},${total_branches} ./${executable}

rm -rf help.out
