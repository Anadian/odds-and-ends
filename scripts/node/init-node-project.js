#!/usr/bin/env node

//const FileSystem = require('fs');
import Sh from 'shelljs';
//const Execa = require('execa');

async function main_Async(){
	var repo_directory = Sh.pwd().stdout;
	console.log( repo_directory );
	if( Sh.env['GITHUB_USERNAME'] !== '' ){
		Sh.mkdir( '-p', 'ci' );
		Sh.mkdir( '-p', '.github/workflows' );
		if( Sh.test( '-f', 'package.json' ) === true ){
			Sh.exec('pnpm install --save-dev ava hjson npm-check-updates standard-version c8 coveralls');
			if( Sh.test( '-e', '.gitignore' ) === false ){
				Sh.echo('node_modules/**').toEnd('.gitignore');
				Sh.echo('.nyc/**').toEnd('.gitignore');
				Sh.echo('coverage/**').toEnd('.gitignore');
			}
			var package_json_string = Sh.cat( 'package.json' ).stdout;
			var package_json_object = JSON.parse( package_json_string );
			package_json_object.scripts = {
				"test": "ava -v ./source/main.test.js",
				"coverage": "c8 pnpm test",
				"coverage-report": "c8 report -r=text-lcov > coverage/lcov.txt",
				"ci": "pnpm coverage && pnpm coverage-report",
				"lint": "eslint ./source/main.js",
				"generate-docs": "extract-documentation-comments -I source/main.js -O API.md",
				"update-config": "hjson -j ci/github-actions.hjson | json2yaml --preserve-key-order -o .github/workflows/ci.yml",
				"update-deps": "npm-check-updates -u",
				"release": "standard-version",
				"publish-release": "git push --follow-tags origin main && pnpm publish"
			};
			package_json_object.type = 'module';
			package_json_object.exports = './source/main.js';

			package_json_object.bin = {};
			package_json_object.bin[package_json_object.name] = './source/main.js';

			package_json_object.engines = {
				node: '>=14.8.0'
			};
			package_json_object.eslintConfig = {
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
			};

			package_json_object['standard-version'] = {
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
			};
			var output_string = JSON.stringify( package_json_object, null, '\t' );
			Sh.echo(`${output_string}`).to('package.json');
		} else{
			console.error('Error: You need to run `npm init` manually before `init-node-project`.');
		//FileSystem.writeFileSync( 'package.json', output_string, 'utf8' );
		}
	} else{
		console.error('Error: GITHUB_USERNAME environment variable is not set.');
	}
}
main_Async();
