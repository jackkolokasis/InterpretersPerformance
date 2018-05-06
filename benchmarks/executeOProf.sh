#!/bin/bash

#############################################################
#
# file: executeOProf.sh
#
# @Author   Iacovos G. Kolokasis
#           Emmanouil Pavlidakis
# @Version  03-05-2018
# @email    kolokasis@ics.forth.gr
#           manospavl@ics.forth.gr
#
# @brief    Execute profiling benchmarks
# 
# Usage 
#   ./executeOProf <interpreter> <executable> <arcitecture>
#
#############################################################

cmd=$1                  # Command
executable=$2           # Executable file
architecture=$3         # Architecture version

# Check input arguments
if [ $# -lt 3 ]
then
	echo "./executeOProf <interpreter> <executable> <arcitecture>"
	echo "Add interpreter (python3.6/java/rhino)."
	echo "Add executable."
	echo "Add architecture (core2/haswell/ivy_bridge/nehalem/amd)."
	exit
fi

# Run ophelp to get event name for branches (different per architecture)
ophelp > help.out

# INTEL
# Core2
# Speculative and Retired referred together
if [ $architecture = "core2" ] 
then
	echo " " $architecture
	#Total Retired Instructions
	total_instr="INST_RETIRED_ANY_P"

	# All miss predicted branches
	miss_pred="BR_MISSP_EXEC"

	# All branches
	total_branches="BR_INST_EXEC"

	# Miss Indirect Branches
	miss_indirect_br="BR_IND_MISSP_EXEC"

	# Indirect branches
	indirect_br="BR_IND_EXEC"

	# Conditional Branches
	conditional_br="BR_CND_EXEC"

	# Miss Conditional Branches
	miss_conditional_br="BR_CND_MISSP_EXEC"

	# Retired
	total_branches_retired="BR_INST_RETIRED"

	# Miss Retired
	total_branches_miss_retired="BR_MISS_PRED_RETIRED"

	# Haswell
elif [ $architecture = "haswell" ] || [ $architecture = "ivy_bridge" ]
then
	echo " " $architecture
	#Total Retired Instructions
	total_instr="INST_RETIRED"

	# Find all miss branches (Conditional + Uncoditional)
	miss_pred="br_misp_exec:0xff"

	# Find all branches (Conditional + Uncoditional)
	total_branches="br_inst_exec:0xff"

	# Miss Indirect Branches
	miss_indirect_br="br_misp_exec:0xc4"

	# All Branches (Speculative executed)
	# Conditional Branches (Speculative executed)
	conditional_br="br_inst_exec:0xc1"

	# Indirect branches
	indirect_br="br_inst_exec:0xc4"

	# Miss predicted Branches (Speculative executed)
	# Conditional Branches
	miss_conditional_br="br_misp_exec:0xc1"

	# Retired
	total_branches_retired="br_inst_retired"

	# Miss Retired
	total_branches_miss_retired="br_misp_retired"

	# Nehalem
elif [ $architecture = "nehalem" ]
then
	echo " " $architecture

	#Total Retired Instructions
	total_instr="INST_RETIRED"


	# Miss Predicted Branches
	miss_pred="BR_MISP_EXEC:0x30"

	# All Branches 
	total_branches="BR_INST_EXEC:0x30"

	# Indirect Branches
	miss_indirect_br="BR_MISP_EXEC:4"

	# All Branches 
	# Conditional Branches (Speculative executed)
	conditional_br="BR_INST_EXEC:1"

	# Indirect Branches
	indirect_br="BR_INST_EXEC:4"

	# Miss predicted Branches (Speculative executed)
	# Conditional Branches
	miss_conditional_br="BR_MISP_EXEC:1"

	# Retired
	total_branches_retired="BR_INST_RETIRED"

	# Miss Retired
	total_branches_miss_retired="BR_MISS_RETIRED"

	# AMD
	# OProfiler do not support speculative optimization.
elif [ $architecture = "amd" ]
then

	#Total Retired Instructions
	total_instr="RETIRED_INSTRUCTIONS"

	# Miss Indirect Branches (Retired)
	miss_indirect_br="RETIRED_INDIRECT_BRANCHES_MISPREDICTED"

	# Retired
	total_branches_retired="RETIRED_BRANCH_INSTRUCTIONS"

	# Miss Retired
	total_branches_miss_retired="RETIRED_MISPREDICTED_BRANCH_INSTRUCTIONS"
fi

# Python
if [ ${cmd} == "python3.6" ]
then
	echo ${cmd}
	#INTEL Archs
	if [ ${architecture} != "amd" ]
	then
		ocount --event ${total_instr},${miss_pred},${total_branches},\
			${miss_indirect_br},${indirect_br},${conditional_br},\
			${miss_conditional_br},${total_branches_retired},\
			${total_branches_miss_retired} ${cmd} ${executable}
		#AMD Archs
	else
		ocount --event ${total_instr},${miss_indirect_br},${total_branches_retired},\
			${total_branches_miss_retired} ${cmd} ${executable}  
	fi
	#Java
elif [ ${cmd} == "java" ]
then
	echo ${cmd}
	#INTEL Archs
	if [ ${architecture} != "amd" ]
	then
		ocount --event ${total_instr},${miss_pred},${total_branches},\
			${miss_indirect_br},${indirect_br},${conditional_br},\
			${miss_conditional_br},${total_branches_retired},\
			${total_branches_miss_retired} ${cmd} -Xint -jar java/dacapo-9.12-bach.jar ${executable}
		#AMD Archs
	else
		ocount --event ${total_instr},${miss_indirect_br},${total_branches_retired},\
			${total_branches_miss_retired} ${cmd} -Xint -jar java/dacapo-9.12-bach.jar ${executable}
	fi

	#JavaScript
else
	echo ${cmd}
	#INTEL Archs
	if [ ${architecture} != "amd" ]
	then
		ocount --event ${total_instr},${miss_pred},${total_branches},\
			${miss_indirect_br},${indirect_br},${conditional_br},\
			${miss_conditional_br},${total_branches_retired},\
			${total_branches_miss_retired} ${cmd} -1 ${executable}
		#AMD Archs
	else
		ocount --event ${total_instr},${miss_indirect_br},${total_branches_retired},\
			${total_branches_miss_retired} ${cmd} -1 ${executable}
	fi
fi
