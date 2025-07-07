#!/bin/bash

exiftool $1 -o temp.dat -all= ;
digest=`sha256sum -b temp.dat | head --bytes 64`;
echo "$1: $digest";
finalhash="f1220$digest";
exiftool -config exiftool.config -XMP-cno:hash=$finalhash $1
#rm temp.dat;
