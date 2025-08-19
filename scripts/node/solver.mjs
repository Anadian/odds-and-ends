#!/usr/bin/env node

const ORIGIN_VECTOR = { x: 0, y: 0 };
function getDistance( pointa = ORIGIN_VECTOR, pointb = ORIGIN_VECTOR ){


function solveTravellingSalesMan( nodes ){
	for( var i = 0; i < nodes.length; i++ ){
		for( var j = i+1; j < nodes.length; j++ ){
			a2 = ( nodes[j].vec[0] - nodes[i].vec[0] )**2;
			b2 = ( nodes[j].vec[1] - nodes[i].vec[1] )**2;
			distance = Math.sqrt( a2+b2 );
			nodes[i].dist[j] = distance;

