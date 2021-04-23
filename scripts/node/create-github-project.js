#!/usr/local/bin/node
const Sh = require('shelljs');
const Inquirer = require('inquirer');

async function main_Async(){
	console.log( process.argv );
	if( process.argv.length > 3 ){
		var project_name = process.argv[2];
		var description = process.argv[3];
		if( process.argv.length > 4 ){
			var license = process.argv[4];
		} else{
			console.error('No license specified.');
		}
		if( description.length <= 120 ){
			if( Sh.env['GITHUB_USERNAME'] !== '' ){
				var inquirer_questions = [
					{
						type: 'confirm',
						name: 'git',
						message: 'Initialise Git repository?'
					},
					{
						type: 'confirm',
						name: 'mit',
						message: 'Add an MIT license to the project directory?'
					},
					{
						type: 'list',
						name: 'post',
						message: 'Run an additional post-run script?',
						choices: [
							'None',
							'node/npm'
						]
					}
				];
				var prompt_promise = Inquirer.prompt( inquirer_questions );
				Sh.mkdir( '-p', `${project_name}/source` );
				var datetime = new Date();
				Sh.echo(`# ${project_name}
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)
[![Semantic Versioning 2.0.0](https://img.shields.io/badge/semver-2.0.0-brightgreen?style=flat-square)](https://semver.org/spec/v2.0.0.html)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg?style=flat-square)](https://conventionalcommits.org)
[![License](https://img.shields.io/github/license/${Sh.env['GITHUB_USERNAME']}/${project_name})](https://github.com/${Sh.env['GITHUB_USERNAME']}/${project_name}/blob/main/LICENSE)

> ${description}
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
${license} ©${datetime.getUTCFullYear()} ${Sh.env['GITHUB_USERNAME']}

SEE LICENSE IN [LICENSE](LICENSE)

[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)\
This project's documentation is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).`).to(`${project_name}/README.md`);
				Sh.cd( project_name );
				Sh.mkdir( '-p', '.github/workflows' );
				var answers_object = await prompt_promise;
				if( answers_object.mit === true ){
					Sh.echo(`MIT ©${datetime.getUTCFullYear()} ${Sh.env['GITHUB_USERNAME']}
	Copyright ${datetime.getUTCFullYear()} ${Sh.env['GITHUB_USERNAME']}
	Permission is hereby granted, free of charge, to any person obtaining a copy of this 
software and associated documentation files (the "Software"), to deal in the Software 
without restriction, including without limitation the rights to use, copy, modify, 
merge, publish, distribute, sublicense, and/or sell copies of the Software, and to 
permit persons to whom the Software is furnished to do so, subject to the following 
conditions:
	The above copyright notice and this permission notice shall be included in all copies 
or substantial portions of the Software.
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.`).to('LICENSE');
				}
				if( answers_object.git === true ){
					Sh.exec('git init');
					Sh.exec( `git remote add origin 'https://github.com/${Sh.env['GITHUB_USERNAME']}/${project_name}'`);
					Sh.exec('git add --all .');
					Sh.exec(`git commit -m 'v0.0.0 First commit.'`);
					Sh.exec('git push -u origin main');
				}
			} else{
				console.error('Error: GITHUB_USERNAME environment variable is not set.');
			}
		} else{
			console.error(`Error: description (${description}) is longer (${descrption.length}) than 120 characters.`);
		}
	} else{
		console.error('Error: not enough arguments specified.');
	}
}

main_Async();
