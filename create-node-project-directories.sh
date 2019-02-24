#!/bin/bash

if [[ $1 == '' ]]; then
	echo 'Error: project name not specified.';
else
	mkdir -p node/npm/node_modules;
	cd node/npm;
	npm install;
	cd ../..;
	ln -s node/npm/node_modules node_modules;
	ln node/npm/package-lock.json package-lock.json;
	mkdir -p scripts;
	mkdir -p source;
	mkdir -p Resources;
	echo "#$1" > README.md;
	git init;
	git remote add origin https://github.com/Anadian/$1.git;
	git add --all .;
	git commit -m 'First commit.';
	git push -u origin master;
fi
