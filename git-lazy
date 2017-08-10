#!/bin/bash
git add --all .;
git commit -m "$1";
if(($# >= 2)); then git push origin $2;
else git push origin master;
fi
