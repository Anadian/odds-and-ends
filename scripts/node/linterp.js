#!/usr/bin/env node
'use strict';

var p1ratings = [
	{ x: 1, y: 9 },
	{ x: 2, y: 9 },
	{ x: 3, y: 7 },
	{ x: 4, y: 8 },
	{ x: 5, y: 8 },
	{ x: 6, y: 8 },
	{ x: 7, y: 8 },
	{ x: 8, y: 5 },
	{ x: 9, y: 9 },
	{ x: 10, y: 7 },
	{ x: 11, y: 7 },
	{ x: 12, y: 9 },
	{ x: 13, y: 7 }
];
var p2ratings = [
	{ x: 1, y: 8 },
	{ x: 2, y: 7 },
	{ x: 3, y: 6 },
	{ x: 4, y: 8 },
	{ x: 5, y: 7 },
	{ x: 6, y: 6 },
	{ x: 7, y: 7 },
	{ x: 8, y: 6 },
	{ x: 9, y: 8 }
];

function linterp( target_x, vec1, vec2 ){
	return vec1.y + ( (target_x - vec1.x)*((vec2.y - vec1.y)/(vec2.x - vec1.x)) );
}

var p1act = 9;
var p2act = 6;
var p1fact = ( p1ratings.length / p1act );
var p2fact = ( p2ratings.length / p2act );

for( var i = 1; i < p1act; i++ ){
	var target_x = i * p1fact;
	var output_y = linterp( target_x, p1ratings[Math.floor( target_x ) - 1], p1ratings[Math.floor( target_x )] )
	console.log( i, target_x, output_y );
}
for( var i = 1; i < p2act; i++ ){
	var target_x = i * p2fact;
	/*var fract = target_x - Math.floor( target_x );
	if( fract < 0.00001 ){
		upperindex = lowerindex + 1;
	}*/
	var output_y = linterp( target_x, p2ratings[Math.floor( target_x ) - 1], p2ratings[Math.floor( target_x )] )
	console.log( i, target_x, output_y );
}
