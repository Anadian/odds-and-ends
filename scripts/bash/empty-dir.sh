#!/bin/bash
for ((i=1; i <= $#; i++))
do
	mv ${!i}/* . && rm -df ${!i}
done
