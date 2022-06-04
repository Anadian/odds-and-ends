#!/usr/bin/env node

//const Sh = require('shelljs');

const URLsafe = require( "speakingurl" );

const FS = require('fs');
const Path = require('path');

for( var i = 2; i < process.argv.length; i++ ){
	var oname = process.argv[i];
	var ext = Path.extname( oname );
	var basename = Path.basename( oname, ext );
	var dirname = Path.dirname( oname );
	var safename = basename.replace( / /g, '_' );
	safename = URLsafe( safename );

	FS.renameSync( oname, Path.join( dirname, safename+ext ) );
}
