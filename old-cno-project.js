#!/usr/bin/env node
import * as PathNS from 'node:path';
import Sh from 'shelljs';
import * as InquirerNS from '@inquirer/prompts';

async function main_Async( options = {} ){
	console.log( process.argv );
	var return_error = null;
	var inquirer_prompt = {};
	var inquirer_answer = null;
	var project_name = ( process.argv[2] || options.project_name ) ?? ( '' );
	var desc = ( process.argv[3] || options.desc ) ?? ( '' );
	//var license = ( process.argv[4] || options.license ) ?? ( '' );
	var project_directory = ( process.argv[4] || options.project_directory ) ?? ( '' );
	var project_git = false;
	var github_username = Sh.env['GITHUB_USERNAME'];
	var github_origin = '';
	var license = 'none';
	var datetime = new Date();
	var package_json = {};
	inquirer_prompt = { message: 'Project name?', default: project_name };
	try{
		project_name = await InquirerNS.input( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.input threw an error: ${error}`);
		throw return_error;
	}
	inquirer_prompt = { message: 'Description (<120)?', default: desc };
	try{
		desc = await InquirerNS.input( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.input threw an error: ${error}`);
		throw return_error;
	}
	inquirer_prompt = { message: 'Create directory?', default: true };
	try{
		inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === true ){
		if( project_directory == '' ){
			console.log('Making default project directory.');
			project_directory = PathNS.join( process.cwd(), project_name );
		}
		inquirer_prompt = { message: 'Directory path?', default: project_directory };
		try{
			project_directory = await InquirerNS.input( inquirer_prompt );
		} catch(error){
			return_error = new Error(`await InquirerNS.input threw an error: ${error}`);
			throw return_error;
		}
		Sh.mkdir( '-p', project_directory );
		Sh.cd( project_directory );
	}
	inquirer_prompt = { message: 'Initialise Git repository?', default: true };
	try{
		inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === true ){
		project_git = true;
		Sh.echo('node_modules/**\ncoverage/**\n').to('.gitignore');
		//github_username = Sh.env['GITHUB_USERNAME'];
		github_username = Sh.exec('git config --get user.name').stdout.trimEnd();
		inquirer_prompt = { message: 'GitHub username?', default: github_username };
		try{
			github_username = await InquirerNS.input( inquirer_prompt );
		} catch(error){
			return_error = new Error(`await InquirerNS.input threw an error: ${error}`);
			throw return_error;
		}
		Sh.exec('git init');
		inquirer_prompt = { message: 'Add origin?', default: true };
		try{
			inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
		} catch(error){
			return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
			throw return_error;
		}
		if( inquirer_answer === true ){
			inquirer_prompt = { message: 'Origin URL?', default: `https://github.com/${github_username}/${project_name}` };
			try{
				github_origin = await InquirerNS.input( inquirer_prompt );
			} catch(error){
				return_error = new Error(`await InquirerNS.input threw an error: ${error}`);
				throw return_error;
			}
			Sh.exec(`git remote add origin ${github_origin}`);
		}
	}
	inquirer_prompt = { message: 'License?', choices: [
		{
			value: 'none',
			name: 'none'
		},
		{
			value: 'mit',
			name: 'MIT'
		}
	] };
	try{
		inquirer_answer = await InquirerNS.select( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.select threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === 'mit' ){
		license = 'MIT';
		Sh.echo(`MIT ©${datetime.getUTCFullYear()} ${github_username}
	Copyright ${datetime.getUTCFullYear()} ${github_username}
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
	inquirer_prompt = { message: 'Initialise Node?', default: true };
	try{
		inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === true ){
		inquirer_prompt = { message: 'Create package.json?', default: true };
		if( inquirer_answer === true ){
			package_json = {
				"name": project_name,
				"version": "0.0.0",
				"description": desc,
				"scripts": {
						"test": "ava -v ./source/main.test.js",
						"coverage": "c8 pnpm test",
						"coverage-report": "c8 report -r=text-lcov > coverage/lcov.txt",
						"ci": "pnpm coverage && pnpm coverage-report",
						"lint": "eslint ./source/main.js",
						"generate-docs": "scripts/generate-docs.js",
						"update-config": "hjson -j ci/github-actions.hjson | json2yaml --preserve-key-order -o .github/workflows/ci.yml",
						"update-deps": "npm-check-updates -u",
						"release": "standard-version",
						"publish-release": "git push --follow-tags origin main && pnpm publish",
				},
				"repository": {
						"type": "git",
						"url": `git+${github_origin}.git`
				},
				"author": github_username,
				"license": license,
				"main": "source/main.js",
				"type": "module",
				"exports": "./source/lib.js",
				"engines": {
						"node": ">=14.8.0"
				},
				"bugs": {
						"url": `${github_origin}/issues`
				},
				"homepage": `${github_origin}#readme`,
				"keywords": [
						"libre",
						"free",
						"open",
						"mit",
				],
				"eslintConfig": {
						"env": {
								"commonjs": true,
								"es6": true,
								"node": true
						},
						"extends": "eslint:recommended",
						"globals": {
								"Atomics": "readonly",
								"SharedArrayBuffer": "readonly"
						},
						"parserOptions": {
								"ecmaVersion": 11
						},
						"rules": {
								"no-unused-vars": [
										"warn"
								],
								"no-useless-escape": "off",
								"no-empty": "warn"
						}
				},
				"standard-version": {
						"types": [
								{
										"type": "build",
										"section": "Build",
										"hidden": false
								},
								{
										"type": "ci",
										"section": "Continuous Integration",
										"hidden": false
								},
								{
										"type": "chore",
										"section": "Chores",
										"hidden": false
								},
								{
										"type": "docs",
										"section": "Documentation",
										"hidden": false
								},
								{
										"type": "feat",
										"section": "Features",
										"hidden": false
								},
								{
										"type": "fix",
										"section": "Bug Fixes",
										"hidden": false
								},
								{
										"type": "perf",
										"section": "Performance",
										"hidden": false
								},
								{
										"type": "refactor",
										"section": "Refactoring",
										"hidden": false
								},
								{
										"type": "style",
										"section": "Code Style",
										"hidden": false
								},
								{
										"type": "test",
										"section": "Tests",
										"hidden": false
								}
						]
				}
			};
			Sh.echo( JSON.stringify( package_json, null, '\t' ) ).to('package.json');
		} //create package.json
		inquirer_prompt = { message: 'Install dev deps?', default: true };
		if( inquirer_answer === true ){
			Sh.exec('pnpm add --save-dev c8 coveralls eslint extract-documentation-comments hjson npm-check-updates standard-version');
		}
	} //Init node
	inquirer_prompt = { message: 'Add README?', default: true };
	try{
		inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === true ){
		Sh.echo(`# ${project_name}
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)
[![Semantic Versioning 2.0.0](https://img.shields.io/badge/semver-2.0.0-brightgreen?style=flat-square)](https://semver.org/spec/v2.0.0.html)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg?style=flat-square)](https://conventionalcommits.org)
[![License](https://img.shields.io/github/license/${github_username}/${project_name})](https://github.com/${github_username}/${project_name}/blob/main/LICENSE)

> ${desc}
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
${license} ©${datetime.getUTCFullYear()} ${github_username}

SEE LICENSE IN [LICENSE](LICENSE)

[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)\
This project's documentation is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).`).to('README.md');
	}
	inquirer_prompt = { message: 'Make initial commit?', default: true };
	try{
		inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === true ){
		Sh.exec('git add --all .');
		Sh.exec(`git commit -m 'v0.0.0 First commit.'`);
		Sh.exec('git push -u origin main');
	}
	inquirer_prompt = { message: 'Initialise CI?', default: true };
	try{
		inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === true ){
		Sh.mkdir( '-p', '.github/workflows' );
	}
}

main_Async();
