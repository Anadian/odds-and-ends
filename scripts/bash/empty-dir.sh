#!/bin/bash
function empty-dir{
	for ((i=1; i <= $#; i++))
	do
		echo "$0 $# $i ${!i}";
		if [[ -d ${!i} ]]; then
			mv ${!i}/* . && rm -df ${!i};
		else
			echo "'${!i}' is not a directory.";
		fi
	done
}
