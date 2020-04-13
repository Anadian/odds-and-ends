#!/bin/bash

current_directory=$(pwd);
echo "current_directory: $current_directory";
repo_name=$(basename $current_directory);
echo "repo_name: $repo_name";
if [[ $GITHUB_USERNAME != '' ]]; then
	mkdir -p ci;
	echo '{
	"language": "node_js",
	"node_js": [
		"node"
	],
	"script": [
		"nyc npm test && nyc report --reporter=text-lcov | ./node_modules/coveralls/bin/coveralls.js"
	]
}' > ci/travis.json;
	echo '#!/bin/bash

scripts_directory=$(dirname $0);
echo "scripts_directory: $scripts_directory";
project_directory="$scripts_directory/..";
echo "project_directory: $project_directory";

cd $project_directory;

json2yaml --preserve-key-order ci/travis.json .travis.yml;' > scripts/update-travis.sh;
	npm init;
	npm install --save-dev ava nyc coveralls;
	chmod 777 scripts/update-travis.sh;
	./scripts/update-travis.sh;
else
	echo 'Error: GITHUB_USERNAME environment variable is not set.';
fi
