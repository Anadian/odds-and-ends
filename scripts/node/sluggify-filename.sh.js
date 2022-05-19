#!/usr/bin/env node

//const Sh = require('shelljs');

const URLsafe = require( "speakingurl" );

const FS = require('fs');

for( var i = 2; i < process.argv.length; i++ ){
	FS.renameSync( process.argv[i], URLsafe( process.argv[i], '_' );
}
