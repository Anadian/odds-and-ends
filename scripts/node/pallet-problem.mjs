#!/usr/bin/env node

const base_units = [
	[ 4, 3 ], //12
	[ 5, 3 ], //15
	[ 5, 4 ], //20
	[ 6, 4 ], //24
	[ 7, 4 ] //28
];

var current_shape = { i: 0, pieces: 0, area: 288, w: 18, h: 16 };

function pointInRange( point, min, max ){
	if( point >= min && point < max ){
		return true;
	} else{
		return false;
	}
}
function intersection1D( vecA, vecB ){
function overlap( rectA, rectB ){
	a_right = rectA.x + rectA.w;
	b_right = rectB.x + rectB.w;
	a_down = rectA.y + rectA.h;
	b_down = rectB.y + rectB.h;
	if( a_right < b_right && a_right >= rectB.x

for( var y = 0; y < 16; y++ ){
	for( var x = 0; x < 18; x++ ){

