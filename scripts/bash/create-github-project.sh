#!/bin/bash
if (( $# >= 2 )); then
	repo_name=$1;
	echo "repo_name: $repo_name";
	repo_description=$2;
	echo "repo_description: $repo_description";
	if (( $# >= 3 )); then
		repo_license=$3;
		echo "repo_license: $repo_license";
	else
		repo_license='';
		echo 'Warn: no repo license specified.';
	fi
	if (( ${#repo_description} < 120 )); then
		if [[ $GITHUB_USERNAME != '' ]]; then
			mkdir -p "$repo_name/Documents" "$repo_name/scripts" "$repo_name/source";
			echo "# $repo_name
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)
[![Semantic Versioning 2.0.0](https://img.shields.io/badge/semver-2.0.0-brightgreen?style=flat-square)](https://semver.org/spec/v2.0.0.html)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg?style=flat-square)](https://conventionalcommits.org)
[![License](https://img.shields.io/github/license/$GITHUB_USERNAME/$repo_name)](https://github.com/$GITHUB_USERNAME/$repo_name/blob/master/LICENSE)

> $repo_description
# Table of Contents
- [Background](#Background)
- [Install](#Install)
- [Usage](#Usage)
- [API](#API)
- [Contributing](#Contributing)
- [License](#License)
# Background
# Install
# Usage
# API
# Contributing
Changes are tracked in [CHANGELOG.md](CHANGELOG.md).
# License
$repo_license ©$(date -u +%Y) $GITHUB_USERNAME

SEE LICENSE IN [LICENSE](LICENSE)

[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)\
This project's documentation is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/)." > $repo_name/README.md;
			echo "$repo_license ©$(date -u +%Y) $GITHUB_USERNAME" > $repo_name/LICENSE;
			echo "$(date -u +%Y-%m-%d) v0.0.0 First commit." > $repo_name/CHANGES.md;
			echo '#!/bin/bash
scripts_directory=$(dirname $0);
echo "scripts_directory: $scripts_directory";
project_directory="$scripts_directory/..";
echo "project_directory: $project_directory";
cd $project_directory;
ln Documents/README.md README.md;
ln Documents/LICENSE LICENSE;
ln Documents/CHANGES.md CHANGES.md;' > $repo_name/scripts/hardlinks.sh;
			#chmod 777 $repo_name/scripts/hardlinks.sh;
			#./$repo_name/scripts/hardlinks.sh;
			cd $repo_name;
			git init;
			git remote add origin "https://github.com/$GITHUB_USERNAME/$repo_name";
			git add --all .;
			git commit -m 'v0.0.0 First commit.';
			git push -u origin master;
		else
			echo 'Error: GITHUB_USERNAME environment variable is not set.';
		fi
	else
		echo "Error: repo_description ($repo_description) is longer (${#repo_descrption}) than 120 characters.";
	fi
else
	echo 'Error: not enough arguments specified.';
fi
