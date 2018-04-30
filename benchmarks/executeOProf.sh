#!/bin/bash
cmd=$1
executable=$2
architecture=$3

if [ $# -eq 0 ]
then
	echo "./executeOProf <interpreter> <executable> <arcitecture>"
	echo "Add interpreter (python/java etc)."
	echo "Add executable."
	echo "Add architecyure (intel/amd)."
	exit
fi

#run ophelp to get event name for branches (different per architecture)
ophelp > help.out

#INTEL
#Skylake + Haswell + Ivy bridge
if [ $architecture = "skylake" ] || [ $architecture = "haswell" ] || [ $architecture = "ivy_bridge" ]
then
	echo " " $architecture
	#miss predicted branches
	miss_pred="br_misp_retired:"
	total_branches="br_inst_retired:"
# AMD
elif [ $architecture = "amd" ]
then
	#miss predicted branches
	miss_pred=`cat help.out | grep -i -B 1 "Retired Mispredicted Branch Instructions" | grep "_" | awk '{print substr($1, 1, length($1)-1)}'`

	#all branches
	total_branches=`cat help.out | grep -i -B 1 "Retired Branch Instructions" | grep "_" | awk '{print substr($1, 1, length($1)-1)}'`
# No info for intel
else
	#miss predicted branches
	miss_pred=`cat help.out | grep -i -B 1 "number of mispredicted branches retired" | grep "_" | awk '{print substr($1, 1, length($1)-1)}'`

	#all branches
	total_branches=`cat help.out | grep -i -B 1 "number of branch instructions retired" | grep "_" | awk '{print substr($1, 1, length($1)-1)}'`

fi

#JavaScript or Python
if [ ${cmd} != "java" ]; then
	# Rhino or Python cmd
	ocount --event ${miss_pred},${total_branches} ${cmd} ${executable}
else
	# Java cmd
	echo "JAVA"
	ocount --event ${miss_pred},${total_branches} ${cmd} -Xint -jar java/dacapo-9.12-bach.jar ${executable}
fi

