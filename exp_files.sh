#!/bin/bash
X=$((2^4));
previous_file='';
new_filename='/Volumes/Untitled/1_bytes.txt';
echo $X;
echo 'a' > /Volumes/Untitled/0_bytes.txt;
echo 'aa' > /Volumes/Untitled/1_bytes.txt;
i=$((0));
while [ $i -lt 36 ]
do
	echo $i;
	previous_filename=$new_filename;
	new_filename="/Volumes/Untitled/$((2^$i))_bytes.txt";
	cat $previous_filename $previous_filename > $new_filename;
	i=$(($i+1));
done
