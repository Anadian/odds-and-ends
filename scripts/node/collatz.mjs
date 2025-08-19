#!/usr/bin/env node

function getCollatzSequence( input ){
	var _return = [];
	var x = input;
	while( x !== 1 ){
		console.log( x );
		if( x % 2 ){
			x = 3*x+1;
		} else{
			x /= 2;
		}
	}
}

getCollatzSequence( process.argv[2] );
