#!/bin/bash
mkdir -p ./$1;
cd $1;
echo "#$1" > README.md;
git init;
git commit -m 'Initial commit.';
git remote add origin https://github.com/Anadian/$1.git;
git push -u origin master;
