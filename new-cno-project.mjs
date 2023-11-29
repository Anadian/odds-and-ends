#!/usr/bin/env node
/**
# [cno-project.js](source/cno-project.js)
> cno-project project manager class.

Author: Anadian

Code license: MIT
```
	Copyright 2023 Anadian
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
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
Documentation License: [![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)
> The source-code comments and documentation are written in [GitHub Flavored Markdown](https://github.github.com/gfm/).

*/

//# Dependencies
	//## Internal
	//## Standard
	import * as PathNS from 'node:path';
	//## External
	import Sh from 'shelljs';
	import * as InquirerNS from '@inquirer/prompts';
	import ParseJSON from 'parse-json';
	import * as ApplicationLogWinstonInterface from 'application-log-winston-inferface';
//# Constants
const FILENAME = 'cno-project.js';
//## Errors

//# Global Variables
/**## Functions*/
/**
### ProjectManager
> A class for managing projects ala cno-project.
#### Parametres
| name | type | description |
| --- | --- | --- |
| options | object? | Additional options to pass to the smart constructor. |

##### Options Properties
| name | type | description |
| --- | --- | --- |
| packageMeta | PackageMeta? | An instance of [simple-package-meta](https://github.com/Anadian/simple-package-meta) to be used by this instance and any subclasses initialised along with it. |
| logger | object? | The logger to be used by this instance. |
| config | ConfigManager? | The [cno-config-manager] instance to be used by the created instance. |

#### Throws
| code | type | condition |
| --- | --- | --- |
| 'ERR_INVALID_ARG_TYPE' | TypeError | Thrown if `options` is neither an object nor `null` |

#### History
| version | change |
| --- | --- |
| 0.0.0 | Introduced |
*/
export default function ProjectManager( options = {} ){
	if( !( this instanceof ProjectManager ) ){
		return new ProjectManager( options );
	}
	const FUNCTION_NAME = 'ProjectManager';
	this.packageMeta = ( this.packageMeta || options.packageMeta ) ?? ( null );
	this.logger = ( this.logger || options.logger ) ?? ( ApplicationLogWinstonInterface.nullLogger );
	this.config = ( this.config || options.config ) ?? ( null );
	//state
	this.project = ( this.project || options.project ) ?? ( {} );
	this.project.directory = ( this.project.directory || options.project.directory ) ?? ( '' );
	this.project.name = ( this.project.name || options.project.name ) ?? ( '' );
	this.project.desc = ( this.project.desc || options.project.desc ) ?? ( '' );
	this.project.readme = ( this.project.readme || options.project.readme ) ?? ( false );
	this.license = ( this.license || options.license ) ?? ( {} );
	this.license.exists = ( this.license.exists || options.license.exists ) ?? ( false );
	this.license.spdx = ( this.license.spdx || options.license.spdx ) ?? ( '' );
	this.packageJSON = ( this.packageJSON || options.packageJSON ) ?? ( {} );
	this.packageJSON.exists = ( this.packageJSON.exists || options.packageJSON.exists ) ?? ( false );
	this.packageJSON.object = ( this.packageJSON.object || options.packageJSON.object ) ?? ( {} );
	this.git = ( this.git || options.git ) ?? ( {} );
	this.git.initialised = ( this.git.initialised || options.git.initialised ) ?? ( false );
	this.git.gitignore = ( this.git.gitignore || options.git.gitignore ) ?? ( false );
	this.git.username = ( this.git.username || options.git.username ) ?? ( '' );
	this.git.origin = ( this.git.origin || options.git.origin ) ?? ( '' );
	this.git.upstreamed = ( this.git.upstreamed || options.git.upstreamed ) ?? ( false );
	this.node = ( this.node || options.node ) ?? ( {} );
	this.node.exists = ( this.node.exists || options.node.exists ) ?? ( false );
	this.agenda = ( this.agenda || options.agenda ) ?? ( { git: false, node: false, documentation: false } );
	return this;
}
/**
### ProjectManager.prototype.promptProjectDirectory
> The first thing it needs to know.

#### Throws
| code | type | condition |
| --- | --- | --- |
| 'ERR_INVALID_ARG_TYPE' | TypeError | Thrown if a given argument isn't of the correct type. |

#### History
| version | change |
| --- | --- |
| 0.0.1 | WIP |
*/
ProjectManager.prototype.promptProjectDirectory = async function(){
	const FUNCTION_NAME = 'ProjectManager.prototype.promptProjectDirectory';
	//Variables
	var arguments_array = Array.from(arguments);
	var return_error = null;
	this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'debug', message: `received: ${arguments_array}`});

	//Function
	var current_directory = '';
	try{
		current_directory = process.cwd();
	} catch(error){
		return_error = new Error(`process.cwd threw an error: ${error}`);
		throw return_error;
	}
	var first_input = process.argv[2];
	if( first_input === '.' ){
		this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'info', message: `Using '${current_directory}' as project diriectory.`});
		this.project.directory = current_directory;
	} else{
		try{
			this.project.directory = PathNS.resolve( first_input );
		} catch(error){
			return_error = new Error(`PathNS.resolve threw an error: ${error}`);
			throw return_error;
		}
	}
	var inquirer_prompt = { };
	var inquirer_answer = null;
	inquirer_prompt = { message: 'Directory path?', default: this.project.directory };
	try{
		this.project.directory = await InquirerNS.input( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.input threw an error: ${error}`);
		throw return_error;
	}
	Sh.mkdir( '-p', this.project.directory );
	Sh.cd( this.project.directory );
}
/**
### ProjectManager.prototype.promptAgenda
> Gets the user set agenda for this cno-project invoktion.

#### Throws
| code | type | condition |
| --- | --- | --- |
| 'ERR_INVALID_ARG_TYPE' | TypeError | Thrown if a given argument isn't of the correct type. |

#### History
| version | change |
| --- | --- |
| 0.0.1 | WIP |
*/
ProjectManager.prototype.promptAgenda = async function(){
	const FUNCTION_NAME = 'ProjectManager.prototype.promptAgenda';
	//Variables
	var arguments_array = Array.from(arguments);
	var return_error = null;
	this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'debug', message: `received: ${arguments_array}`});

	//Function
	var inquirer_prompt = {};
	var inquirer_answer = null;
	inquirer_prompt = { message: 'Select which submodules are needed.', choices: [
		{ name: 'Git', value: 'git', checked: true },
		{ name: 'Node', value: 'node', checked: true },
		{ name: 'Documentation', value: 'documentation', checked: true }
	] };
	try{
		inquirer_answer = await InquirerNS.checkbox( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.checkbox threw an error: ${error}`);
		throw return_error;
	}
	for( const answer of inquirer_answer ){
		this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'info', message: `Needing ${answer}`});
		this.agenda[answer] = true;
	}
}
/**
### ProjectManager.prototype.collectInfo
> Reads the filesystem and environment variables to hopefully offer smarter defaults.

#### Parametres
| name | type | description |
| --- | --- | --- |
| options | object? | [Reserved] Additional run-time options. \[default: {}\] |

#### Throws
| code | type | condition |
| --- | --- | --- |
| 'ERR_INVALID_ARG_TYPE' | TypeError | Thrown if a given argument isn't of the correct type. |

#### History
| version | change |
| --- | --- |
| 0.0.1 | WIP |
*/
ProjectManager.prototype.collectInfo = async function( options = {} ){
	const FUNCTION_NAME = 'ProjectManager.prototype.collectInfo';
	//Variables
	var arguments_array = Array.from(arguments);
	var return_error = null;
	this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'debug', message: `received: ${arguments_array}`});
	var inquirer_prompt = null;
	var inquirer_answer = null;
	//Parametre checks
	if( typeof(options) !== 'object' ){
		return_error = new TypeError('Param "options" is not object?.');
		return_error.code = 'ERR_INVALID_ARG_TYPE';
		throw return_error;
	}

	//Function
	if( Sh.test( '-f', 'package.json' ) === true ){
		this.packageJSON.exists = true;
		var json_object = {};
		try{
			json_object = ParseJSON( Sh.cat('package.json').stdout );
		} catch(error){
			return_error = new Error(`ParseJSON threw an error: ${error}`);
			throw return_error;
		}
		this.packageJSON.object = json_object;
		this.project.name = this.packageJSON.object.name;
		this.project.desc = this.packageJSON.object.desc;
		this.license.spdx = this.packageJSON.object.license;
	}
	if( this.project.name == '' ){
		var base = '';
		try{
			base = PathNS.basename( this.project.directory );
		} catch(error){
			return_error = new Error(`PathNS.basename threw an error: ${error}`);
			throw return_error;
		}
		this.project.name = base;
	}
	inquirer_prompt = { message: 'Project name?', default: this.project.name };
	try{
		inquirer_answer = await InquirerNS.input( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.input threw an error: ${error}`);
		throw return_error;
	}
	this.project.name = inquirer_answer;
	inquirer_prompt = { message: 'Project description?', default: this.project.desc };
	try{
		inquirer_answer = await InquirerNS.input( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.input threw an error: ${error}`);
		throw return_error;
	}
	this.project.desc = inquirer_answer;
	inquirer_prompt = { message: 'Project license? (SPDX identifier)', default: this.project.license };
	try{
		inquirer_answer = await InquirerNS.input( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.input threw an error: ${error}`);
		throw return_error;
	}
	this.license.spdx = inquirer_answer;
	if( Sh.test( '-f', 'LICENSE' ) === true ){
		this.license.exists = true;
	}
	if( Sh.test( '-d', '.git' ) === true ){
		this.git.initialised = true;
		if( this.git.username == '' ){
			this.git.username = Sh.exec('git config --get user.name').stdout.trimEnd();
			inquirer_prompt = { message: 'GitHub username?', default: this.git.username };
			try{
				inquirer_answer = await InquirerNS.input( inquirer_prompt );
			} catch(error){
				return_error = new Error(`await InquirerNS.input threw an error: ${error}`);
				throw return_error;
			}
		}
		var match = Sh.exec('git remote show origin').stdout.match( /Fetch URL: (.*)/ );
		console.log(`${this.git.origin} | ${match[1]} | https://github.com/${this.git.username}/${this.project.name}`);
		this.git.origin = ( this.git.origin || match[1] ) ?? `https://github.com/${this.git.username}/${this.project.name}`;
		inquirer_prompt = { message: 'Git Origin URL?', default: this.git.origin };
		try{
			inquirer_answer = await InquirerNS.input( inquirer_prompt );
		} catch(error){
			return_error = new Error(`await InquirerNS.input threw an error: ${error}`);
			throw return_error;
		}
		this.git.origin = inquirer_answer;
	}
	if( Sh.test( '-f', '.gitignore' ) === true ){
		this.git.gitignore = true;
	}
	if( Sh.test( '-d', 'node_modules' ) ){
		this.node.exists = true;
	}
	if( Sh.test( '-f', 'LICENSE' ) === true ){
		this.license.exists = true;
	}
	if( Sh.test( '-f', 'README.md' ) === true ){
		this.project.readme = true;
	}
}
/**
### ProjectManager.prototype.processGit
> Processes Git-related things.

#### Parametres
| name | type | description |
| --- | --- | --- |
| options | object? | [Reserved] Additional run-time options. \[default: {}\] |

#### Throws
| code | type | condition |
| --- | --- | --- |
| 'ERR_INVALID_ARG_TYPE' | TypeError | Thrown if a given argument isn't of the correct type. |

#### History
| version | change |
| --- | --- |
| 0.0.1 | WIP |
*/
ProjectManager.prototype.processGit = async function( options = {} ){
	const FUNCTION_NAME = 'ProjectManager.prototype.processGit';
	//Variables
	var arguments_array = Array.from(arguments);
	var return_error = null;
	this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'debug', message: `received: ${arguments_array}`});
	var inquirer_prompt = null;
	var inquirer_answer = null;
	//Parametre checks
	if( typeof(options) !== 'object' ){
		return_error = new TypeError('Param "options" is not object?.');
		return_error.code = 'ERR_INVALID_ARG_TYPE';
		throw return_error;
	}

	//Function
	if( this.git.initialised === false ){
		inquirer_prompt = { message: 'Initialise Git repository?', default: true };
		try{
			inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
		} catch(error){
			return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
			throw return_error;
		}
		if( inquirer_answer === true ){
			Sh.exec('git init');
			this.git.initialised = true;
			//github_username = Sh.env['GITHUB_USERNAME'];
		}
	}
	if( this.git.gitignore === false ){
		inquirer_prompt = { message: 'Create .gitignore?', default: true };
		try{
			inquirer_answer = await InquirerNS.input( inquirer_prompt );
		} catch(error){
			return_error = new Error(`await InquirerNS.input threw an error: ${error}`);
			throw return_error;
		}
		Sh.echo('node_modules/**\ncoverage/**\n').to('.gitignore');
	}
	inquirer_prompt = { message: `Add origin? ( current: ${this.git.origin} )`, default: true };
	try{
		inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === true ){
		Sh.exec(`git remote add origin ${this.git.origin}`);
	}
}
/**
### ProjectManager.prototype.processNode
> Process Node stuff.

#### Parametres
| name | type | description |
| --- | --- | --- |
| options | object? | [Reserved] Additional run-time options. \[default: {}\] |

#### Throws
| code | type | condition |
| --- | --- | --- |
| 'ERR_INVALID_ARG_TYPE' | TypeError | Thrown if a given argument isn't of the correct type. |

#### History
| version | change |
| --- | --- |
| 0.0.1 | WIP |
*/
ProjectManager.prototype.processNode = async function( options = {} ){
	const FUNCTION_NAME = 'ProjectManager.prototype.processNode';
	//Variables
	var arguments_array = Array.from(arguments);
	var return_error = null;
	this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'debug', message: `received: ${arguments_array}`});
	var inquirer_prompt = null;
	var inquirer_answer = null;
	//Parametre checks
	if( typeof(options) !== 'object' ){
		return_error = new TypeError('Param "options" is not object?.');
		return_error.code = 'ERR_INVALID_ARG_TYPE';
		throw return_error;
	}

	//Function
	if( this.packageJSON.exists != true ){
		inquirer_prompt = { message: 'Create package.json?', default: true };
		try{
			inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
		} catch(error){
			return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
			throw return_error;
		}
		if( inquirer_answer === true ){ //Init node
			this.node.exists = true;
			this.packageJSON.object = {
				"name": this.project.name,
				"version": "0.0.0",
				"description": this.project.desc,
				"repository": {
						"type": "git",
						"url": `git+${this.git.origin}.git`
				},
				"author": this.git.username,
				"license": this.project.license,
				"main": "source/main.js",
				"type": "module",
				"exports": "./source/lib.js",
				"engines": {
						"node": ">=14.8.0"
				},
				"bugs": {
						"url": `${this.git.origin}/issues`
				},
				"homepage": `${this.git.origin}#readme`,
				"keywords": [
						"libre",
						"free",
						"open",
						"mit",
				]
			}
		}
	}
	inquirer_prompt = { message: 'Add scripts?', default: true };
	try{
		inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === true ){
		this.packageJSON.scripts = Object.assign( this.packageJSON.scripts, {
				"test": "node --test ./source/main.test.js",
				"coverage": "c8 pnpm test",
				"coverage-report": "c8 report -r=text-lcov > coverage/lcov.txt",
				"ci": "pnpm coverage && pnpm coverage-report",
				"lint": "eslint ./source/main.js",
				"generate-docs": "scripts/generate-docs.js",
				"update-config": "hjson -j ci/github-actions.hjson | json2yaml --preserve-key-order -o .github/workflows/ci.yml",
				"update-deps": "npm-check-updates -u",
				"release": "standard-version",
				"publish-release": "git push --follow-tags origin main && pnpm publish",
		} );
	}
	inquirer_prompt = { message: 'Add eslint?', default: false };
	try{
		inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === true ){
		this.packageJSON.eslintConfig = Object.assign( this.packageJSON.eslintConfig, {
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
		} );
	}
	inquirer_prompt = { message: 'Add standard-version?', default: true };
	try{
		inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === true ){
		this.packageJSON['standard-version'] = Object.assign( this.packageJSON['standard-version'], {
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
		} );
	}
	inquirer_prompt = { message: 'Save new package.json?', default: true };
	try{
		inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === true ){
		Sh.echo( JSON.stringify( package_json, null, '\t' ) ).to('package.json');
	}
	inquirer_prompt = { message: 'Install dev deps?', default: true };
	try{
		inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
	} catch(error){
		return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
		throw return_error;
	}
	if( inquirer_answer === true ){
		Sh.exec('pnpm add --save-dev c8 coveralls eslint extract-documentation-comments hjson npm-check-updates standard-version');
	}
}
/**
### ProjectManager.prototype.processDocumentation
> Processes documentation

#### Parametres
| name | type | description |
| --- | --- | --- |
| options | object? | [Reserved] Additional run-time options. \[default: {}\] |

#### Throws
| code | type | condition |
| --- | --- | --- |
| 'ERR_INVALID_ARG_TYPE' | TypeError | Thrown if a given argument isn't of the correct type. |

#### History
| version | change |
| --- | --- |
| 0.0.1 | WIP |
*/
ProjectManager.prototype.processDocumentation = async function( options = {} ){
	const FUNCTION_NAME = 'ProjectManager.prototype.processDocumentation';
	//Variables
	var arguments_array = Array.from(arguments);
	var return_error = null;
	this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'debug', message: `received: ${arguments_array}`});
	var datetime = new Date();
	var inquirer_prompt = null;
	var inquirer_answer = null;
	//Parametre checks
	if( typeof(options) !== 'object' ){
		return_error = new TypeError('Param "options" is not object?.');
		return_error.code = 'ERR_INVALID_ARG_TYPE';
		throw return_error;
	}

	//Function
	if( this.license.exists != true ){
		inquirer_prompt = { message: 'Add LICENSE?', default: true };
		try{
			inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
		} catch(error){
			return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
			throw return_error;
		}
		if( inquirer_answer === true ){
			inquirer_prompt = { message: 'Select license?', choices: [
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
				this.license = 'MIT';
				Sh.echo(`MIT ©${datetime.getUTCFullYear()} ${this.git.username}
	Copyright ${datetime.getUTCFullYear()} ${this.git.username}
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
		}
	}
	if( this.project.readme != true ){
		inquirer_prompt = { message: 'Add README?', default: true };
		try{
			inquirer_answer = await InquirerNS.confirm( inquirer_prompt );
		} catch(error){
			return_error = new Error(`await InquirerNS.confirm threw an error: ${error}`);
			throw return_error;
		}
		if( inquirer_answer === true ){
			Sh.echo(`# ${this.project.name}
	[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)
	[![Semantic Versioning 2.0.0](https://img.shields.io/badge/semver-2.0.0-brightgreen?style=flat-square)](https://semver.org/spec/v2.0.0.html)
	[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg?style=flat-square)](https://conventionalcommits.org)
	[![License](https://img.shields.io/github/license/${this.git.username}/${this.project.name})](https://github.com/${this.git.username}/${this.project.name}/blob/main/LICENSE)

	> ${this.project.desc}
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
	${this.license.spdx} ©${datetime.getUTCFullYear()} ${this.git.username}

	SEE LICENSE IN [LICENSE](LICENSE)

	[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)\
	This project's documentation is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).`).to('README.md');
		}
	}
}
async function main_Async( options = {} ){
	console.log( process.argv );
	var return_error = null;
	var project_manager = new ProjectManager( { 
		project: {
			directory: process.argv[2],
			name: process.argv[3],
			desc: process.argv[4]
		},
		license: { spdx: process.argv[5] }
	} );
	await project_manager.promptProjectDirectory();
	await project_manager.promptAgenda();
	await project_manager.collectInfo();
	if( project_manager.agenda.git ){
		await project_manager.processGit();
	}
	if( project_manager.agenda.node ){
		await project_manager.processNode();
	}
	if( project_manager.agenda.documentation ){
		await project_manager.processDocumentation();
	}
}

main_Async();
