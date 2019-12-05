#!/bin/bash

current_directory=$(pwd);
echo "current_directory: $current_directory";
repo_name=$(basename $current_directory);
echo "repo_name: $repo_name";
if [[ $GITHUB_USERNAME != '' ]]; then
	go mod init github.com/$GITHUB_USERNAME/$repo_name;
	go get golang.org/tools/x/cmd/cover;
	go get github.com/mattn/goveralls;
	mkdir -p ci;
	echo '{
	"language": "go",
	"go": [
		"1.13",
		"master"
	],
	"before_install": [
		"go get golang.org/x/tools/cmd/cover",
		"go get github.com/mattn/goveralls"
	],
	"script": [
		"$GOPATH/bin/goveralls -service=travis-ci"
	]
}' > ci/travis.json;
	echo '#!/bin/bash

scripts_directory=$(dirname $0);
echo "scripts_directory: $scripts_directory";
project_directory="$scripts_directory/..";
echo "project_directory: $project_directory";

cd $project_directory;

json2yaml --preserve-key-order ci/travis.json .travis.yml;' > scripts/update-travis.sh;
	chmod 777 scripts/update-travis.sh;
	./scripts/update-travis.sh;
else
	echo 'Error: GITHUB_USERNAME environment variable is not set.';
fi
