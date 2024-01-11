#!/usr/local/bin/node

/*
Flavours:
- POSIX
- EXTENDED
- PCRE
- VIM
- ECMA
- RE2
Glossary:
- <LOP> Literal Openning Paran
- <LCP> Literal Closing Paran
- <MOP> Magic Openning Paran
- <MCP> Magic Closing Paran
- <LB> Line Break
- <LPS> Literal Plus Sign
- <OMQ> One or More Quantifier
- <ZOQ> Zero or One Quantifier
- <ZMQ> Zero or More Quantifier
- <VRQ_START:$minimum:$maximum:VRQ_END> Variable Range Quantifier
- <LES> Literal Equal Sign
- <LQM> Literal Question Mark
- <LLT> Literal Less Than <
- <LGT> Literal Greater Than >
- <CHARACTER_CLASS_START:$Content:CHARACTER_CLASS_END>
*/

if( process.argv.length >= 2 ){
	var input_string = process.argv[2];
	var intermediary_string = input_string.replace(/\\\(/g, '<LOP>');
	var intermediary_string = intermediary_string.replace( /\\\)/g, '<LCP>' );
	//Convert magic params to intermediary
	intermediary_string = intermediary_string.replace( /\(/g, '<MOP>' );
	intermediary_string = intermediary_string.replace( /\)/g, '<MCP>' );
	//Convert new lines to carriage returns
	intermediary_string = intermediary_string.replace( /\\n/g, '\\r' );
	//Convert pluses to intermediary
	intermediary_string = intermediary_string.replace( /\\\+/g, '<LPS>' );
	intermediary_string = intermediary_string.replace( /([^\\])\+/, '$1<OMQ>' );
	//Convert Magic 0 or 1 `?`s to vim \=
	intermediary_string = intermediary_string.replace( /([^\\])\?/, '$1<ZOQ>' );
	console.log('Marked-up intermediary: ', intermediary_string);
	//Convert plus intermediaries to vim-regex syntax
	intermediary_string = intermediary_string.replace( /<OMQ>/g, '\\+' );
	intermediary_string = intermediary_string.replace( /<LPS>/g, '+' );
	//Convert Magic params
	intermediary_string = intermediary_string.replace( /<MOP>/g, '\\(' );
	intermediary_string = intermediary_string.replace( /<MCP>/g, '\\)' );
	//Convet literal params
	intermediary_string = intermediary_string.replace( /<LOP>/g, '(' );
	intermediary_string = intermediary_string.replace( /<LCP>/g, ')' );
	console.log(intermediary_string);
}
