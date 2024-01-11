#!/usr/local/bin/node
'use strict'

const FILENAME = 'regex-translator.js';
const MODULE_NAME = 'RegexTranslator';
var PACKAGE_JSON = {};
var PROCESS_NAME = '';
if(require.main === module){
	PROCESS_NAME = 'regex-translator';
} else{
	PROCESS_NAME = process.argv0;
}
//##Errors

//#Global Variables
/* istanbul ignore next */
var Logger = { 
	log: () => {
		return null;
	}
};
var MetaRegexObject = {
	"default": {
		"LLT": {
			to: {
				search_regex: /</g,
				replace_string: '<LLT>'
			}, 
			from: {
				search_regex: /<LLT>/g,
				replace_string: '<' 
			}
		},
		"LGT": {
			to: {
				search_regex: />/g,
				replace_string: '<LGT>'
			}, 
			from: {
				search_regex: /<LGT>/g,
				replace_string: '>' 
			}
		},
		"CHARACTER_CLASS": { 
			to: {
				search_regex: /([^\\])\[([^\]]*?)\]/g,
				replace_string: '$1<CHARACTER_CLASS_START:$2:CHARACTER_CLASS_END>'
			}, 
			from: {
				search_regex: /<CHARACTER_CLASS_START:(.*?):CHARACTER_CLASS_END>/g,
				replace_string: '[$1]' 
			}
		},
		"LVRQ": {
			to: {
				search_regex: /([^\\])\{(\d*),(\d*)\}\?/g,
				replace_string: '$1<LVRQ_START:$2:$3:LVRQ_END>'
			},
			from: {
				search_regex: /<LVRQ_START:(\d*):(\d*):LVRQ_END>/g,
				replace_string: '{$1,$2}?'
			}
		},
		"VRQ": {
			to: {
				search_regex: /([^\\])\{(\d*),(\d*)\}/g,
				replace_string: '$1<VRQ_START:$2:$3:VRQ_END>'
			},
			from: {
				search_regex: /<VRQ_START:(\d*):(\d*):VRQ_END/g,
				replace_string: '{$1,$2}'
			}
		},
		"LOMQ": {
			to: {
				search_regex: /\+\?/g,
				replace_string: '<LOMQ>'
			},
			from: {
				search_regex: /<LOMQ>/g,
				replace_string: '+?'
			}
		},
		"LZMQ": {
			to: {
				search_regex: /\*\?/g,
				replace_string: '<LZMQ>'
			},
			from: {
				search_regex: /<LZMQ>/g,
				replace_string: '*?'
			}
		},
		"LOP": {
			to: {
				search_regex: /\\\(/g,
				replace_string: '<LOP>'
			},
			from: {
				search_regex: /<LOP>/g,
				replace_string: '\\('
			}
		},
		"LCP": {
			to: {
				search_regex: /\\\)/g,
				replace_string: '<LCP>'
			},
			from: {
				search_regex: /<LCP>/g,
				replace_string: '\\)'
			}
		},
		"MOP": {
			to: {
				search_regex: /\(/g,
				replace_string: '<MOP>'
			},
			from: {
				search_regex: /<MOP>/g,
				replace_string: '('
			}
		},
		"MCP": {
			to: {
				search_regex: /\)/g,
				replace_string: '<MCP>'
			},
			from: {
				search_regex: /<MCP>/g,
				replace_string: ')'
			}
		},
		"LB": {
			to: {
				search_regex: /\n/g,
				replace_string: '<LB>'
			},
			from: {
				search_regex: /<LB>/g,
				replace_string: '\\n'
			}
		},
		"LBS": {
			to: {
				search_regex: /\\\\/g,
				replace_string: '<LBS>'
			},
			from: {
				search_regex: /<LBS>/g,
				replace_string: '\\\\'
			}
		},
		"LPS": {
			to: {
				search_regex: /\\\+/g,
				replace_string: '<LPS>'
			},
			from: {
				search_regex: /<LPS>/g,
				replace_string: '\\+'
			}
		},
		"LP": {
			to: {
				search_regex: /\\\./g,
				replace_string: '<LP>'
			},
			from: {
				search_regex: /<LP>/g,
				replace_string: '\\.'
			}
		},
		"LCS": {
			to: {
				search_regex: /\\\^/g,
				replace_string: '<LCS>'
			},
			from: {
				search_regex: /<LCS>/g,
				replace_string: '\\^'
			}
		},
		"LDS": {
			to: {
				search_regex: /\\\$/g,
				replace_string: '<LDS>'
			},
			from: {
				search_regex: /<LDS>/g,
				replace_string: '\\$'
			}
		},
		"LES": {
			to: {
				search_regex: /\=/g,
				replace_string: '<LES>'
			},
			from: {
				search_regex: /<LES>/g,
				replace_string: '\\='
			}
		},
		"LQM": {
			to: {
				search_regex: /\\\?/g,
				replace_string: '<LQM>'
			},
			from: {
				search_regex: /<LQM>/g,
				replace_string: '\\?'
			}
		},
		"LAS": {
			to: {
				search_regex: /\\\*/g,
				replace_string: '<LAS>'
			},
			from: {
				search_regex: /<LAS>/g,
				replace_string: '\\*'
			}
		},
		"LPIPE": {
			to: {
				search_regex: /\\\|/g,
				replace_string: '<LPIPE>'
			},
			from: {
				search_regex: /<LPIPE>/g,
				replace_string: '\\|'
			}
		},
		"ORA": {
			to: {
				search_regex: /\|/g,
				replace_string: '<ORA>'
			},
			from: {
				search_regex: /<ORA>/g,
				replace_string: '|'
			}
		},
		"LFS": {
			to: {
				search_regex: /\\\//g,
				replace_string: '<LFS>'
			},
			from: {
				search_regex: /<LFS>/g,
				replace_string: '\\\/'
			}
		},
		"OMQ": {
			to: {
				search_regex: /\+/g,
				replace_string: '<OMQ>'
			},
			from: {
				search_regex: /<OMQ>/g,
				replace_string: '+'
			}
		},
		"ZOQ": {
			to: {
				search_regex: /\?/g,
				replace_string: '<ZOQ>'
			},
			from: {
				search_regex: /<ZOQ>/g,
				replace_string: '?'
			}
		},
		"ZMQ": {
			to: {
				search_regex: /\*/g,
				replace_string: '<ZMQ>'
			},
			from: {
				search_regex: /<ZMQ>/g,
				replace_string: '*'
			}
		},
		"MAC": {
			to: {
				search_regex: /\./g,
				replace_string: '<MAC>'
			},
			from: {
				search_regex: /<MAC>/g,
				replace_string: '.'
			}
		},
		"SL": {
			to: {
				search_regex: /\^/g,
				replace_string: '<SL>'
			},
			from: {
				search_regex: /<SL>/g,
				replace_string: '^'
			}
		},
		"EL": {
			to: {
				search_regex: /\$/g,
				replace_string: '<EL>'
			},
			from: {
				search_regex: /<EL>/g,
				replace_string: '$'
			}
		},
		"RS": {
			to: {
				search_regex: /\//g,
				replace_string: '<RS>'
			},
			from: {
				search_regex: /<RS>/g,
				replace_string: '/'
			}
		},
		"CC_DIGIT": {
			to: {
				search_regex: /(\[:digit:\])|(\\d)/g,
				replace_string: '<CC_DIGIT>'
			},
			from: {
				search_regex: /<CC_DIGIT>/g,
				replace_string: '[0-9]'
			}
		},
		"CC_NOTDIGIT": {
			to: {
				search_regex: /\\D/g,
				replace_string: '<CC_NOTDIGIT>'
			},
			from: {
				search_regex: /<CC_NOTDIGIT>/g,
				replace_string: '[^0-9]'
			}
		},
		"CC_WORD": {
			to: {
				search_regex: /\\w/g,
				replace_string: '<CC_WORD>'
			},
			from: {
				search_regex: /<CC_WORD>/g,
				replace_string: '[A-Za-z0-9_]'
			}
		},
		"CC_NOTWORD": {
			to: {
				search_regex: /\\W/g,
				replace_string: '<CC_NOTWORD>'
			},
			from: {
				search_regex: /<CC_NOTWORD>/g,
				replace_string: '[^A-Za-z0-9_]'
			}
		},
		"CC_alnum": {
			to: {
				search_regex: /\[:alnum:\]/g,
				replace_string: '<CC_alnum>'
			},
			from: {
				search_regex: /<CC_alnum>/g,
				replace_string: '[A-Za-z0-9]'
			}
		},
		"CC_alpha": {
			to: {
				search_regex: /\[:alpha:\]/g,
				replace_string: '<CC_alpha>'
			},
			from: {
				search_regex: /<CC_alpha>/g,
				replace_string: '[A-Za-z]'
			}
		},
		"CC_graph": {
			to: {
				search_regex: /\[:graph:\]/g,
				replace_string: '<CC_graph>'
			},
			from: {
				search_regex: /<CC_graph>/g,
				replace_string: '[!-~]'
			}
		},
		"CC_lower": {
			to: {
				search_regex: /\[:lower:\]/g,
				replace_string: '<CC_lower>'
			},
			from: {
				search_regex: /<CC_lower>/g,
				replace_string: '[a-z]'
			}
		},
		"CC_print": {
			to: {
				search_regex: /\[:print:\]/g,
				replace_string: '<CC_print>'
			},
			from: {
				search_regex: /<CC_print>/g,
				replace_string: '[ -~]'
			}
		},
		"CC_punct": {
			to: {
				search_regex: /\[:punct:\]/g,
				replace_string: '<CC_punct>'
			},
			from: {
				search_regex: /<CC_punct>/g,
				replace_string: '[!-/:-@[-`{-~]'
			}
		},
		"CC_upper": {
			to: {
				search_regex: /\[:upper:\]/g,
				replace_string: '<CC_upper>'
			},
			from: {
				search_regex: /<CC_upper>/g,
				replace_string: '[A-Z]'
			}
		},
		"CC_xdigit": {
			to: {
				search_regex: /\[:xdigit:\]/g,
				replace_string: '<CC_xdigit>'
			},
			from: {
				search_regex: /<CC_xdigit>/g,
				replace_string: '[0-9A-Fa-f]'
			}
		},
		"CC_NOTNEWLINE": {
			to: {
				search_regex: /\\N/g,
				replace_string: '<CC_NOTNEWLINE>'
			},
			from: {
				search_regex: /<CC_NOTNEWLINE>/g,
				replace_string: '[^\\r\\n]'
			}
		},
		"CC_HORIZONTALSPACE": {
			to: {
				search_regex: /(\[:blank:\])|(\\h)/g,
				replace_string: '<CC_HORIZONTALSPACE>'
			},
			from: {
				search_regex: /<CC_HORIZONTALSPACE>/g,
				replace_string: '[ \\t]'
			}
		},
		"CC_NOTHORIZONTALSPACE": {
			to: {
				search_regex: /\\H/g,
				replace_string: '<CC_NOTHORIZONTALSPACE>'
			},
			from: {
				search_regex: /<CC_NOTHORIZONTALSPACE>/g,
				replace_string: '[^ \\t]'
			}
		},
		"CC_VERTICALSPACE": {
			to: {
				search_regex: /(\[:space:\])|(\\s)|(\\v)/g,
				replace_string: '<CC_VERTICALSPACE>'
			},
			from: {
				search_regex: /<CC_VERTICALSPACE>/g,
				replace_string: '[\\f\\n\\r\\t\\v]'
			}
		},
		"CC_NOTVERTICALSPACE": {
			to: {
				search_regex: /(\\S)|(\\V)/g,
				replace_string: '<CC_NOTVERTICALSPACE>'
			},
			from: {
				search_regex: /<CC_NOTVERTICALSPACE>/g,
				replace_string: '[^\\f\\n\\r\\t\\v]'
			}
		},
		"CC_R": {
			to: {
				search_regex: /\[:R:\]/g,
				replace_string: '<CC_R>'
			},
			from: {
				search_regex: /<CC_R>/g,
				replace_string: '[\\r\\n\\f\\t\\v]'
			}
		}
	},
	"pcre": {
		"LLT": {
			to: {
				search_regex: /</g,
				replace_string: '<LLT>'
			}, 
			from: {
				search_regex: /<LLT>/g,
				replace_string: '<' 
			}
		},
		"LGT": {
			to: {
				search_regex: />/g,
				replace_string: '<LGT>'
			}, 
			from: {
				search_regex: /<LGT>/g,
				replace_string: '>' 
			}
		},
		"CHARACTER_CLASS": { 
			to: {
				search_regex: /([^\\])\[([^\]]*?)\]/g,
				replace_string: '$1<CHARACTER_CLASS_START:$2:CHARACTER_CLASS_END>'
			}, 
			from: {
				search_regex: /<CHARACTER_CLASS_START:(.*?):CHARACTER_CLASS_END>/g,
				replace_string: '[$1]' 
			}
		},
		"LVRQ": {
			to: {
				search_regex: /([^\\])\{(\d*),(\d*)\}\?/g,
				replace_string: '$1<LVRQ_START:$2:$3:LVRQ_END>'
			},
			from: {
				search_regex: /<LVRQ_START:(\d*):(\d*):LVRQ_END>/g,
				replace_string: '{$1,$2}?'
			}
		},
		"VRQ": {
			to: {
				search_regex: /([^\\])\{(\d*),(\d*)\}/g,
				replace_string: '$1<VRQ_START:$2:$3:VRQ_END>'
			},
			from: {
				search_regex: /<VRQ_START:(\d*):(\d*):VRQ_END/g,
				replace_string: '{$1,$2}'
			}
		},
		"LOMQ": {
			to: {
				search_regex: /\+\?/g,
				replace_string: '<LOMQ>'
			},
			from: {
				search_regex: /<LOMQ>/g,
				replace_string: '+?'
			}
		},
		"LZMQ": {
			to: {
				search_regex: /\*\?/g,
				replace_string: '<LZMQ>'
			},
			from: {
				search_regex: /<LZMQ>/g,
				replace_string: '*?'
			}
		},
		"LOP": {
			to: {
				search_regex: /\\\(/g,
				replace_string: '<LOP>'
			},
			from: {
				search_regex: /<LOP>/g,
				replace_string: '\\('
			}
		},
		"LCP": {
			to: {
				search_regex: /\\\)/g,
				replace_string: '<LCP>'
			},
			from: {
				search_regex: /<LCP>/g,
				replace_string: '\\)'
			}
		},
		"MOP": {
			to: {
				search_regex: /\(/g,
				replace_string: '<MOP>'
			},
			from: {
				search_regex: /<MOP>/g,
				replace_string: '('
			}
		},
		"MCP": {
			to: {
				search_regex: /\)/g,
				replace_string: '<MCP>'
			},
			from: {
				search_regex: /<MCP>/g,
				replace_string: ')'
			}
		},
		"LB": {
			to: {
				search_regex: /\n/g,
				replace_string: '<LB>'
			},
			from: {
				search_regex: /<LB>/g,
				replace_string: '\\n'
			}
		},
		"LBS": {
			to: {
				search_regex: /\\\\/g,
				replace_string: '<LBS>'
			},
			from: {
				search_regex: /<LBS>/g,
				replace_string: '\\\\'
			}
		},
		"LPS": {
			to: {
				search_regex: /\\\+/g,
				replace_string: '<LPS>'
			},
			from: {
				search_regex: /<LPS>/g,
				replace_string: '\\+'
			}
		},
		"LP": {
			to: {
				search_regex: /\\\./g,
				replace_string: '<LP>'
			},
			from: {
				search_regex: /<LP>/g,
				replace_string: '\\.'
			}
		},
		"LCS": {
			to: {
				search_regex: /\\\^/g,
				replace_string: '<LCS>'
			},
			from: {
				search_regex: /<LCS>/g,
				replace_string: '\\^'
			}
		},
		"LDS": {
			to: {
				search_regex: /\\\$/g,
				replace_string: '<LDS>'
			},
			from: {
				search_regex: /<LDS>/g,
				replace_string: '\\$'
			}
		},
		"LES": {
			to: {
				search_regex: /\=/g,
				replace_string: '<LES>'
			},
			from: {
				search_regex: /<LES>/g,
				replace_string: '\\='
			}
		},
		"LQM": {
			to: {
				search_regex: /\\\?/g,
				replace_string: '<LQM>'
			},
			from: {
				search_regex: /<LQM>/g,
				replace_string: '\\?'
			}
		},
		"LAS": {
			to: {
				search_regex: /\\\*/g,
				replace_string: '<LAS>'
			},
			from: {
				search_regex: /<LAS>/g,
				replace_string: '\\*'
			}
		},
		"LPIPE": {
			to: {
				search_regex: /\\\|/g,
				replace_string: '<LPIPE>'
			},
			from: {
				search_regex: /<LPIPE>/g,
				replace_string: '\\|'
			}
		},
		"ORA": {
			to: {
				search_regex: /\|/g,
				replace_string: '<ORA>'
			},
			from: {
				search_regex: /<ORA>/g,
				replace_string: '|'
			}
		},
		"LFS": {
			to: {
				search_regex: /\\\//g,
				replace_string: '<LFS>'
			},
			from: {
				search_regex: /<LFS>/g,
				replace_string: '\\\/'
			}
		},
		"OMQ": {
			to: {
				search_regex: /\+/g,
				replace_string: '<OMQ>'
			},
			from: {
				search_regex: /<OMQ>/g,
				replace_string: '+'
			}
		},
		"ZOQ": {
			to: {
				search_regex: /\?/g,
				replace_string: '<ZOQ>'
			},
			from: {
				search_regex: /<ZOQ>/g,
				replace_string: '?'
			}
		},
		"ZMQ": {
			to: {
				search_regex: /\*/g,
				replace_string: '<ZMQ>'
			},
			from: {
				search_regex: /<ZMQ>/g,
				replace_string: '*'
			}
		},
		"MAC": {
			to: {
				search_regex: /\./g,
				replace_string: '<MAC>'
			},
			from: {
				search_regex: /<MAC>/g,
				replace_string: '.'
			}
		},
		"SL": {
			to: {
				search_regex: /\^/g,
				replace_string: '<SL>'
			},
			from: {
				search_regex: /<SL>/g,
				replace_string: '^'
			}
		},
		"EL": {
			to: {
				search_regex: /\$/g,
				replace_string: '<EL>'
			},
			from: {
				search_regex: /<EL>/g,
				replace_string: '$'
			}
		},
		"RS": {
			to: {
				search_regex: /\//g,
				replace_string: '<RS>'
			},
			from: {
				search_regex: /<RS>/g,
				replace_string: '/'
			}
		},
		"CC_DIGIT": {
			to: {
				search_regex: /(\[:digit:\])|(\\d)/g,
				replace_string: '<CC_DIGIT>'
			},
			from: {
				search_regex: /<CC_DIGIT>/g,
				replace_string: '[0-9]'
			}
		},
		"CC_NOTDIGIT": {
			to: {
				search_regex: /\\D/g,
				replace_string: '<CC_NOTDIGIT>'
			},
			from: {
				search_regex: /<CC_NOTDIGIT>/g,
				replace_string: '[^0-9]'
			}
		},
		"CC_WORD": {
			to: {
				search_regex: /\\w/g,
				replace_string: '<CC_WORD>'
			},
			from: {
				search_regex: /<CC_WORD>/g,
				replace_string: '[A-Za-z0-9_]'
			}
		},
		"CC_NOTWORD": {
			to: {
				search_regex: /\\W/g,
				replace_string: '<CC_NOTWORD>'
			},
			from: {
				search_regex: /<CC_NOTWORD>/g,
				replace_string: '[^A-Za-z0-9_]'
			}
		},
		"CC_alnum": {
			to: {
				search_regex: /\[:alnum:\]/g,
				replace_string: '<CC_alnum>'
			},
			from: {
				search_regex: /<CC_alnum>/g,
				replace_string: '[A-Za-z0-9]'
			}
		},
		"CC_alpha": {
			to: {
				search_regex: /\[:alpha:\]/g,
				replace_string: '<CC_alpha>'
			},
			from: {
				search_regex: /<CC_alpha>/g,
				replace_string: '[A-Za-z]'
			}
		},
		"CC_graph": {
			to: {
				search_regex: /\[:graph:\]/g,
				replace_string: '<CC_graph>'
			},
			from: {
				search_regex: /<CC_graph>/g,
				replace_string: '[!-~]'
			}
		},
		"CC_lower": {
			to: {
				search_regex: /\[:lower:\]/g,
				replace_string: '<CC_lower>'
			},
			from: {
				search_regex: /<CC_lower>/g,
				replace_string: '[a-z]'
			}
		},
		"CC_print": {
			to: {
				search_regex: /\[:print:\]/g,
				replace_string: '<CC_print>'
			},
			from: {
				search_regex: /<CC_print>/g,
				replace_string: '[ -~]'
			}
		},
		"CC_punct": {
			to: {
				search_regex: /\[:punct:\]/g,
				replace_string: '<CC_punct>'
			},
			from: {
				search_regex: /<CC_punct>/g,
				replace_string: '[!-/:-@[-`{-~]'
			}
		},
		"CC_upper": {
			to: {
				search_regex: /\[:upper:\]/g,
				replace_string: '<CC_upper>'
			},
			from: {
				search_regex: /<CC_upper>/g,
				replace_string: '[A-Z]'
			}
		},
		"CC_xdigit": {
			to: {
				search_regex: /\[:xdigit:\]/g,
				replace_string: '<CC_xdigit>'
			},
			from: {
				search_regex: /<CC_xdigit>/g,
				replace_string: '[0-9A-Fa-f]'
			}
		},
		"CC_NOTNEWLINE": {
			to: {
				search_regex: /\\N/g,
				replace_string: '<CC_NOTNEWLINE>'
			},
			from: {
				search_regex: /<CC_NOTNEWLINE>/g,
				replace_string: '[^\\r\\n]'
			}
		},
		"CC_HORIZONTALSPACE": {
			to: {
				search_regex: /(\[:blank:\])|(\\h)/g,
				replace_string: '<CC_HORIZONTALSPACE>'
			},
			from: {
				search_regex: /<CC_HORIZONTALSPACE>/g,
				replace_string: '[ \\t]'
			}
		},
		"CC_NOTHORIZONTALSPACE": {
			to: {
				search_regex: /\\H/g,
				replace_string: '<CC_NOTHORIZONTALSPACE>'
			},
			from: {
				search_regex: /<CC_NOTHORIZONTALSPACE>/g,
				replace_string: '[^ \\t]'
			}
		},
		"CC_VERTICALSPACE": {
			to: {
				search_regex: /(\[:space:\])|(\\s)|(\\v)/g,
				replace_string: '<CC_VERTICALSPACE>'
			},
			from: {
				search_regex: /<CC_VERTICALSPACE>/g,
				replace_string: '[\\f\\n\\r\\t\\v]'
			}
		},
		"CC_NOTVERTICALSPACE": {
			to: {
				search_regex: /(\\S)|(\\V)/g,
				replace_string: '<CC_NOTVERTICALSPACE>'
			},
			from: {
				search_regex: /<CC_NOTVERTICALSPACE>/g,
				replace_string: '[^\\f\\n\\r\\t\\v]'
			}
		},
		"CC_R": {
			to: {
				search_regex: /\[:R:\]/g,
				replace_string: '<CC_R>'
			},
			from: {
				search_regex: /<CC_R>/g,
				replace_string: '[\\r\\n\\f\\t\\v]'
			}
		}
	},
	"vim": {
		"LLT": {
			to: {
				search_regex: /</g,
				replace_string: '<LLT>'
			}, 
			from: {
				search_regex: /<LLT>/g,
				replace_string: '<' 
			}
		},
		"LGT": {
			to: {
				search_regex: />/g,
				replace_string: '<LGT>'
			}, 
			from: {
				search_regex: /<LGT>/g,
				replace_string: '>' 
			}
		},
		"CHARACTER_CLASS": { 
			to: {
				search_regex: /([^\\])\[([^\]]*?)\]/g,
				replace_string: '$1<CHARACTER_CLASS_START:$2:CHARACTER_CLASS_END>'
			}, 
			from: {
				search_regex: /<CHARACTER_CLASS_START:(.*?):CHARACTER_CLASS_END>/g,
				replace_string: '[$1]' 
			}
		},
		"LVRQ": {
			to: {
				search_regex: /([^\\])\\\{-?(\d*),(\d*)\}/g,
				replace_string: '$1<LVRQ_START:$2:$3:LVRQ_END>'
			},
			from: {
				search_regex: /<LVRQ_START:(\d*):(\d*):LVRQ_END>/g,
				replace_string: '\\{-$1,$2}'
			}
		},
		"VRQ": {
			to: {
				search_regex: /([^\\])\\\{(\d*),(\d*)\}/g,
				replace_string: '$1<VRQ_START:$2:$3:VRQ_END>'
			},
			from: {
				search_regex: /<VRQ_START:(\d*):(\d*):VRQ_END/g,
				replace_string: '\\{$1,$2}'
			}
		},
		"LOMQ": {
			to: {
				search_regex: /\\\{-1,\}/g,
				replace_string: '<LOMQ>'
			},
			from: {
				search_regex: /<LOMQ>/g,
				replace_string: '\\{-1,}'
			}
		},
		"LZMQ": {
			to: {
				search_regex: /\\\{-\}/g,
				replace_string: '<LZMQ>'
			},
			from: {
				search_regex: /<LZMQ>/g,
				replace_string: '\\{-}'
			}
		},
		"LOP": {
			to: {
				search_regex: /\(/g,
				replace_string: '<LOP>'
			},
			from: {
				search_regex: /<LOP>/g,
				replace_string: '('
			}
		},
		"LCP": {
			to: {
				search_regex: /\)/g,
				replace_string: '<LCP>'
			},
			from: {
				search_regex: /<LCP>/g,
				replace_string: ')'
			}
		},
		"MOP": {
			to: {
				search_regex: /\\\(/g,
				replace_string: '<MOP>'
			},
			from: {
				search_regex: /<MOP>/g,
				replace_string: '\\('
			}
		},
		"MCP": {
			to: {
				search_regex: /\\\)/g,
				replace_string: '<MCP>'
			},
			from: {
				search_regex: /<MCP>/g,
				replace_string: '\\)'
			}
		},
		"LB": {
			to: {
				search_regex: /\\r/g,
				replace_string: '<LB>'
			},
			from: {
				search_regex: /<LB>/g,
				replace_string: '\\r'
			}
		},
		"LBS": {
			to: {
				search_regex: /\\\\/g,
				replace_string: '<LBS>'
			},
			from: {
				search_regex: /<LBS>/g,
				replace_string: '\\\\'
			}
		},
		"LPS": {
			to: {
				search_regex: /\+/g,
				replace_string: '<LPS>'
			},
			from: {
				search_regex: /<LPS>/g,
				replace_string: '+'
			}
		},
		"LP": {
			to: {
				search_regex: /\\\./g,
				replace_string: '<LP>'
			},
			from: {
				search_regex: /<LP>/g,
				replace_string: '\\.'
			}
		},
		"LCS": {
			to: {
				search_regex: /\\\^/g,
				replace_string: '<LCS>'
			},
			from: {
				search_regex: /<LCS>/g,
				replace_string: '\\^'
			}
		},
		"LDS": {
			to: {
				search_regex: /\\\$/g,
				replace_string: '<LDS>'
			},
			from: {
				search_regex: /<LDS>/g,
				replace_string: '\\$'
			}
		},
		"LES": {
			to: {
				search_regex: /=/g,
				replace_string: '<LES>'
			},
			from: {
				search_regex: /<LES>/g,
				replace_string: '='
			}
		},
		"LQM": {
			to: {
				search_regex: /\?/g,
				replace_string: '<LQM>'
			},
			from: {
				search_regex: /<LQM>/g,
				replace_string: '?'
			}
		},
		"LAS": {
			to: {
				search_regex: /\\\*/g,
				replace_string: '<LAS>'
			},
			from: {
				search_regex: /<LAS>/g,
				replace_string: '\\*'
			}
		},
		"LPIPE": {
			to: {
				search_regex: /\|/g,
				replace_string: '<LPIPE>'
			},
			from: {
				search_regex: /<LPIPE>/g,
				replace_string: '|'
			}
		},
		"ORA": {
			to: {
				search_regex: /\\\|/g,
				replace_string: '<ORA>'
			},
			from: {
				search_regex: /<ORA>/g,
				replace_string: '\\|'
			}
		},
		"LFS": {
			to: {
				search_regex: /\\\//g,
				replace_string: '<LFS>'
			},
			from: {
				search_regex: /<LFS>/g,
				replace_string: '\\/'
			}
		},
		"OMQ": {
			to: {
				search_regex: /\\\+/g,
				replace_string: '<OMQ>'
			},
			from: {
				search_regex: /<OMQ>/g,
				replace_string: '\\+'
			}
		},
		"ZOQ": {
			to: {
				search_regex: /\\=/g,
				replace_string: '<ZOQ>'
			},
			from: {
				search_regex: /<ZOQ>/g,
				replace_string: '\\='
			}
		},
		"ZMQ": {
			to: {
				search_regex: /\*/g,
				replace_string: '<ZMQ>'
			},
			from: {
				search_regex: /<ZMQ>/g,
				replace_string: '*'
			}
		},
		"MAC": {
			to: {
				search_regex: /\./g,
				replace_string: '<MAC>'
			},
			from: {
				search_regex: /<MAC>/g,
				replace_string: '.'
			}
		},
		"SL": {
			to: {
				search_regex: /\^/g,
				replace_string: '<SL>'
			},
			from: {
				search_regex: /<SL>/g,
				replace_string: '^'
			}
		},
		"EL": {
			to: {
				search_regex: /\$/g,
				replace_string: '<EL>'
			},
			from: {
				search_regex: /<EL>/g,
				replace_string: '$'
			}
		},
		"RS": {
			to: {
				search_regex: /\//g,
				replace_string: '<RS>'
			},
			from: {
				search_regex: /<RS>/g,
				replace_string: '/'
			}
		},
		"CC_DIGIT": {
			to: {
				search_regex: /(\[:digit:\])|(\\d)/g,
				replace_string: '<CC_DIGIT>'
			},
			from: {
				search_regex: /<CC_DIGIT>/g,
				replace_string: '[0-9]'
			}
		},
		"CC_NOTDIGIT": {
			to: {
				search_regex: /\\D/g,
				replace_string: '<CC_NOTDIGIT>'
			},
			from: {
				search_regex: /<CC_NOTDIGIT>/g,
				replace_string: '[^0-9]'
			}
		},
		"CC_WORD": {
			to: {
				search_regex: /\\w/g,
				replace_string: '<CC_WORD>'
			},
			from: {
				search_regex: /<CC_WORD>/g,
				replace_string: '[A-Za-z0-9_]'
			}
		},
		"CC_NOTWORD": {
			to: {
				search_regex: /\\W/g,
				replace_string: '<CC_NOTWORD>'
			},
			from: {
				search_regex: /<CC_NOTWORD>/g,
				replace_string: '[^A-Za-z0-9_]'
			}
		},
		"CC_alnum": {
			to: {
				search_regex: /\[:alnum:\]/g,
				replace_string: '<CC_alnum>'
			},
			from: {
				search_regex: /<CC_alnum>/g,
				replace_string: '[A-Za-z0-9]'
			}
		},
		"CC_alpha": {
			to: {
				search_regex: /\[:alpha:\]/g,
				replace_string: '<CC_alpha>'
			},
			from: {
				search_regex: /<CC_alpha>/g,
				replace_string: '[A-Za-z]'
			}
		},
		"CC_graph": {
			to: {
				search_regex: /\[:graph:\]/g,
				replace_string: '<CC_graph>'
			},
			from: {
				search_regex: /<CC_graph>/g,
				replace_string: '[!-~]'
			}
		},
		"CC_lower": {
			to: {
				search_regex: /\[:lower:\]/g,
				replace_string: '<CC_lower>'
			},
			from: {
				search_regex: /<CC_lower>/g,
				replace_string: '[a-z]'
			}
		},
		"CC_print": {
			to: {
				search_regex: /\[:print:\]/g,
				replace_string: '<CC_print>'
			},
			from: {
				search_regex: /<CC_print>/g,
				replace_string: '[ -~]'
			}
		},
		"CC_punct": {
			to: {
				search_regex: /\[:punct:\]/g,
				replace_string: '<CC_punct>'
			},
			from: {
				search_regex: /<CC_punct>/g,
				replace_string: '[!-/:-@[-`{-~]'
			}
		},
		"CC_upper": {
			to: {
				search_regex: /\[:upper:\]/g,
				replace_string: '<CC_upper>'
			},
			from: {
				search_regex: /<CC_upper>/g,
				replace_string: '[A-Z]'
			}
		},
		"CC_xdigit": {
			to: {
				search_regex: /\[:xdigit:\]/g,
				replace_string: '<CC_xdigit>'
			},
			from: {
				search_regex: /<CC_xdigit>/g,
				replace_string: '[0-9A-Fa-f]'
			}
		},
		"CC_NOTNEWLINE": {
			to: {
				search_regex: /\\N/g,
				replace_string: '<CC_NOTNEWLINE>'
			},
			from: {
				search_regex: /<CC_NOTNEWLINE>/g,
				replace_string: '[^\\r\\n]'
			}
		},
		"CC_HORIZONTALSPACE": {
			to: {
				search_regex: /(\[:blank:\])|(\\h)/g,
				replace_string: '<CC_HORIZONTALSPACE>'
			},
			from: {
				search_regex: /<CC_HORIZONTALSPACE>/g,
				replace_string: '[ \\t]'
			}
		},
		"CC_NOTHORIZONTALSPACE": {
			to: {
				search_regex: /\\H/g,
				replace_string: '<CC_NOTHORIZONTALSPACE>'
			},
			from: {
				search_regex: /<CC_NOTHORIZONTALSPACE>/g,
				replace_string: '[^ \\t]'
			}
		},
		"CC_VERTICALSPACE": {
			to: {
				search_regex: /(\[:space:\])|(\\s)|(\\v)/g,
				replace_string: '<CC_VERTICALSPACE>'
			},
			from: {
				search_regex: /<CC_VERTICALSPACE>/g,
				replace_string: '[\\f\\n\\r\\t\\v]'
			}
		},
		"CC_NOTVERTICALSPACE": {
			to: {
				search_regex: /(\\S)|(\\V)/g,
				replace_string: '<CC_NOTVERTICALSPACE>'
			},
			from: {
				search_regex: /<CC_NOTVERTICALSPACE>/g,
				replace_string: '[^\\f\\n\\r\\t\\v]'
			}
		},
		"CC_R": {
			to: {
				search_regex: /\[:R:\]/g,
				replace_string: '<CC_R>'
			},
			from: {
				search_regex: /<CC_R>/g,
				replace_string: '[\\r\\n\\f\\t\\v]'
			}
		}
	}
};
//#Functions
/**
## Functions
*/
/**
### setLogger
> Allows this module's functions to log the given logger object.

Parametres:
| name | type | description |
| --- | --- | --- |
| logger | {?object} | The logger to be used for logging or `null` to disable logging. |

Throws:
| code | type | condition |
| --- | --- | --- |
| 'ERR_INVALID_ARG_TYPE' | {TypeError} | Thrown if `logger` is neither an object nor `null` |

Status:
| version | change |
| --- | --- |
| 0.0.0 | Introduced |
*/
function setLogger( logger ){
	var return_error = null;
	//const FUNCTION_NAME = 'setLogger';
	//Variables
	//Parametre checks
	/* istanbul ignore else */
	if( typeof(logger) === 'object' ){
		/* istanbul ignore next */
		if( logger === null ){
			logger = { 
				log: () => {
					return null;
				}
			};
		}
	} else{
		return_error = new TypeError('Param "logger" is not an object.');
		return_error.code = 'ERR_INVALID_ARG_TYPE';
		throw return_error;
	}

	//Function
	Logger = logger;
	//Return
}
/**
### getMediaryStringFromRegexString
> Returns an intermediary string with special characters converted to a flavour-agnostic syntax.

Parametres:
| name | type | description |
| --- | --- | --- |
| regex_string | {string} | A string of the regex to be converted.  |
| input_flavour_string | {string} | The flavour of the input string. \[default: \] |
| options | {?Object} | [Reserved] Additional run-time options. \[default: {}\] |

Returns:
| type | description |
| --- | --- |
| {string} | The intermediary string after converting the input regex string. |

Throws:
| code | type | condition |
| --- | --- | --- |
| 'ERR_INVALID_ARG_TYPE' | {TypeError} | Thrown if a given argument isn't of the correct type. |

Status:
| version | change |
| --- | --- |
| 0.0.1 | Introduced |
*/
function getMediaryStringFromRegexString( regex_string, input_flavour_string = 'pcre', options = {},){
	var arguments_array = Array.from(arguments);
	var _return;
	var return_error;
	const FUNCTION_NAME = 'getMediaryStringFromRegexString';
	Logger.log({process: PROCESS_NAME, module: MODULE_NAME, file: FILENAME, function: FUNCTION_NAME, level: 'debug', message: `received: ${arguments_array}`});
	//Variables
	var to_object = {};
	var to_values_array = {};
	var intermediary_string = regex_string;
	//Parametre checks
	if( typeof(regex_string) !== 'string' ){
		return_error = new TypeError('Param "regex_string" is not string.');
		return_error.code = 'ERR_INVALID_ARG_TYPE';
		throw return_error;
	}
	if( typeof(input_flavour_string) !== 'string' ){
		return_error = new TypeError('Param "input_flavour_string" is not string.');
		return_error.code = 'ERR_INVALID_ARG_TYPE';
		throw return_error;
	}

	//Function
	to_object = MetaRegexObject[input_flavour_string];
	console.log( 'to_object: %o', to_object );
	to_values_array = Array.from(Object.values(to_object));
	console.log( 'to_values_array: %o', to_values_array );
	for( var i = 0; i < to_values_array.length; i++ ){
		intermediary_string = intermediary_string.replace( to_values_array[i].to.search_regex, to_values_array[i].to.replace_string );
		console.log(intermediary_string);
	}

	//Return
	Logger.log({process: PROCESS_NAME, module: MODULE_NAME, file: FILENAME, function: FUNCTION_NAME, level: 'debug', message: `returned: ${_return}`});
	return _return;
}


console.log( getMediaryStringFromRegexString( 't*h+i?s{5,10} (is)|[a] simple <pcre> regex$', 'pcre' ) );
