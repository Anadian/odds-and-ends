#!/usr/bin/env node
/*var perms_array = [];
var previous_array = [ 1, 2, 3, 4, 5, 6, 7, 8 ];
var current_array = [ 1, 2, 3, 4, 5, 6, 8, 7 ];
for( var i = 7; i > 0; i-- ){
	if( previous_array[i] >== 8 ){
		eight_count++;
	}
	if( eight_count >= (8 - i) ){
		current_array[i] = 1;
	} 
}*/

function uniquePermIndex( pi ){
	var _return = {
		unique: true,
		digit_string: ''
	};
	var digit = []; 
	for( var i = 0; i < 8; i++ ){
		var divisor = 8**i;
		var qoutient = pi / divisor;
		var floor = Math.floor( qoutient );
		var mod = floor % 0o10;
		digit.push( mod );
		for( var j = 0; j < i; j++ ){
			if( digit[j] == digit[i] ){
				_return.unique = false;
				j = 8;
				i = 8;
			}
		}
		_return.digit_string += String.fromCodePoint( 49 + mod );
	}
	return _return;
}
for( var perm_index = 0o01234567; perm_index <= 0o76543210; perm_index++ ){
	var function_return = uniquePermIndex( perm_index );
	if( function_return.unique === true ){
		console.log( function_return.digit_string );
	}
}
