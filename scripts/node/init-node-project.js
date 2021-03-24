#!/usr/local/bin/node

const FileSystem = require('fs');

var package_json_string = FileSystem.readFileSync( 'package.json', 'utf8' );
var package_json_object = JSON.parse( package_json_string );
package_json_object.scripts = {
    "test": "ava -v ./source/main.test.js",
    "lint": "eslint ./source/main.js",
    "generate-docs": "extract-documentation-comments -I source/main.js -O API.md",
    "update-config": "hjson -j ci/github-actions.hjson | json2yaml --preserve-key-order -o .github/workflows/ci.yml",
    "update-deps": "npm-check-updates -u",
    "release": "standard-version",
    "publish-release": "git push --follow-tags origin main && npm publish"
};

package_json_object.bin = {};
package_json_object.bin[package_json_object.name] = './source/main.js';

package_json_object.engines = {
	node: '>=12'
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
output_string = JSON.stringify( package_json_object, null, '\t' );
FileSystem.writeFileSync( 'package.json', output_string, 'utf8' );
