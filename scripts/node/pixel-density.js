#!/usr/local/bin

console.log(process.argv);
if( process.argv.length === 5 ){
	var diag_inch = parseFloat( process.argv[2] );
	var width_res = parseInt( process.argv[3], 10 );
	var height_res = parseInt( process.argv[4], 10 );
	var diag_mm = diag_inch * 25.4;
	var ratio = width_res / height_res;
	var x = Math.sqrt((diag_mm**2)/(ratio + 1))
	var area_mm2 = (ratio * x)*x;
	var pixel_density = (width_res * height_res) / area_mm2;
	console.log( pixel_density );
}

