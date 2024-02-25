%g/.*\/\/p$/de

"C-JSON Object set string property (<Object>,<Property>)
%s/cjsonsetstring(\([a-z0-9_]*\),\([a-z_]*\))/JSON_Status set_\2_return = json_object_set_string(\1_object, "\2", (*environment).\1.\2);/ge

"c safe xdg getenv with default macro (<VariableName>,<PropertyName>,<DefaultValue>)
%s/^xdg(\([A-Z_]*\),\([a-z_]*\),\([^)]*\))/if(getenv("\1") != NULL) C\\String_Copy(\&((*environment_xdg).\2), getenv("\1"));\relse C\\String_Copy(\&((*environment_xdg).\2), "\3");/ge

"javascript function macro (<FunctionName>,<Arguments>)
%s/jsfunctionmacro(\([^,]*\),\([^)]*\))/function \1(\2){\r\tconsole.log("%s: ", arguments.callee.name, \2);\r\tvar _return = [0,null];\r\t\r\tconsole.log("%s returned: ", arguments.callee.name, _return);\r\treturn _return;\r}/ge

"BASH test macro (<TestName>,<TestCommand>)
%s/bash\\test(\([a-zA-Z0-9_-]*\),\(.*\))$/# Test: \1\rtest_name='\1';\rtest_results[$test_name]=0;\recho '\2';\r\2 1>temp_stdout.txt 2>temp_stderr.txt;\rtest_code=$?;\rtest_stdout=`cat temp_stdout.txt`;\rtest_stderr=`cat temp_stderr.txt`;\rrm temp_stdout.txt temp_stderr.txt;\rif [[ $test_code ]]; then\r\t\relse\r\ttest_results[$test_name]=0;\r\techo "Test: $test_name failed with erroneous exit code $test_code (stderr: '$test_stderr')";\rfi\r/ge

%s/\(\t*\)js\\syscall(\([A-Za-z0-9_]*\))/\1var \2 = \r\1console.log('\2: %o', \2);/ge

%s/js\\ava(\([A-Za-z0-9_:]*\))/AVA( '\1', function( t ){\r\tt.log( t.title );\r\t\r} )/ge

"Javascript

" JSON schema reference 
%s/jsc\\ref(\([A-Za-z0-9_-]\+\))/"$ref": "#\/$defs\/\1"/ge

"javascript start c8 ignore
%s/js\\c0/\/* c8 ignore start *\//ge

"javascript start c8 ignore
%s/js\\c1/\/* c8 ignore stop *\//ge

"javascript comment c8 ignore next
%s/js\\cin/\/* c8 ignore next *\//ge

"javascript comment istanbul ignore next
%s/js\\iin/\/* istanbul ignore next *\//ge

"javascript smart constructor
%s/js\\sc(\([A-Za-z0-9_]*\))/function \1( options ){\r\tif( !( this instanceof \1 ) ){\r\t\treturn ( new \1( options ) );\r\t}\r\treturn this;\r}/ge

"javascript property default
%s/js\\pd(\([A-Za-z0-9_.]*\),\(.*\))$/this.\1 = ( this.\1 || options.\1 ) ?? ( \2 );/ge

"javascript try/catch function macro
%s/^\(\t*\)js\\tc(\(var \)\{,1}\([A-Za-z0-9_.]\+ = \)\{,1}\([A-Za-z0-9_. ]\+\)(\([^)]*\)))$/\1try{\r\1\t\2\3\4(\5);\r\1} catch(error){\r\1\treturn_error = new Error(`\4 threw an error: \${error}`);\r\1\tthrow return_error;\r\1}/ge

"javascript NodeJS test throws function
%s/js\\tt(\([^)]*\))/Test( \1, function( t ){\r\tt.diagnostic( t.name );\r\tconst expected = {\r\t\tinstanceOf: TypeError,\r\t\tcode: 'ERR_INVALID_ARG_TYPE'\r\t};\r\tconst input_function = LoggerNS.initLogger.bind( null, 0 );\r\tconst validator_function = errorExpected.bind( null, expected );\r\tAssert.throws( input_function, validator_function );\r} );/ge

"javascript promise block
%s/^\(\t*\)js\\promise(\([A-Za-z0-9_.]\+\)\(([^)]*)\)\=)$/\1\2\3.then(\r\1\t() => {\r\1\t\t\r\1\t},\r\1\t( error ) => {\r\1\t\treturn_error = new Error(`\2 threw an error: \${error}`);\r\1\t\tthrow return_error;\r\1\t}\r\1); \/\/\2/ge

"javascript 'strictly not equal' operator (=!=)
%s/ \([^= ]\+\) \?=!= \?\([^= ]\+\) / ( \1 != \2 \&\& typeof(\1) === typeof(\2) ) /ge

"Util\fmt -> Utility.format
%s/Util\\fmt/Utility.format/ge

"go\msi -> map[string]interface{}
%s/go\\msi/map[string]interface{}/ge

"cs\log(<string>) > Debug.Log($"{gameObject.name}: {name}: {fname}: <string>");
%s/^\(\t*\)cs\\log(\([^)]*\))/\1Debug.Log($"{Time.frameCount}: {gameObject.name}: {cname}: {fname}: \2");/ge

" Component script function (<function_signature_string>)
%s/^\(\t*\)cs\\csf(\([A-Za-z0-9_]\+\) \([A-Za-z0-9_]\+\)(\(.*\)))$/\1\2 \3(\4){\r\1\tstring fname="\3";\r\1}/ge
"cs\iac Input Action callback function (<name>)
%s/^\(\t*\)cs\\iac(\(\w\+\))/\1public void \2( InputAction.CallbackContext context ){\r\1\tstring fname = "\2";\r\1}/ge

"cs\ac(<CLIPENUM>) -> animation_playables[AnimationClip.]
%s/cs\\ac(\(\w\+\))/animation_playables[AnimationClip.\1]/ge

"cs\AMP -> AnimationMixerPlayable
%s/cs\\AMP/AnimationMixerPlayable/ge

"\amp -> _animation_mixer_playable
%s/\\amp/_animation_mixer_playable/ge

" Animation playable and mix connect
%s/^\(\t*\)cs\\am(\(\w\+\),\(\d\))/\1\2_playable = AnimationClipPlayable.Create( playable_graph, \2_clip );\r\1playable_graph.Connect( \2_playable, 0, animation_mixer_playable, \3 );/ge

"AnimationStateComponent
%s/cs\\asc/animation_state_component/ge

" AnimationClipPlayable from AnimationClip name
%s/cs\\acp(\(\w\+\))/\1_playable = AnimationClipPlayable.Create( playable_graph, \1_clip );/ge

"Unity AnimationPlayable from clip
"%s/^\(\t*\)cs\\ani(\(\w\+\))/\1AnimationClipPlayable \2_playable = AnimationClipPlayable.Create( playable_graph, \2_clip );\r\1AnimationPlayableOutput \2_playable_output = AnimationPlayableOutput.Create( playable_graph, "\2", animator_component );/ge
%s/^\(\t*\)cs\\ani(\(\w\+\))/\1\2_playable = AnimationClipPlayable.Create( playable_graph, \2_clip );/ge

"javascript debug log
"%s/jsdebuglog(\(.*\))$/ApplicationLog.log(PROCESS_NAME,MODULE_NAME,FILENAME,FUNCTION_NAME,'debug',\1);/ge
%s/jsdebuglog(\(.*\))$/this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'debug', message: \1});/ge

"javascript info log
"%s/jsinfolog(\(.*\))$/Logger.log({process: PROCESS_NAME, module: MODULE_NAME, file: FILENAME, function: FUNCTION_NAME, level: 'info', message: \1});/ge
%s/jsinfolog(\(.*\))$/this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'info', message: \1});/ge

"javascript note log
"%s/jsnotelog(\(.*\))$/Logger.log({process: PROCESS_NAME, module: MODULE_NAME, file: FILENAME, function: FUNCTION_NAME, level: 'note', message: \1});/ge
%s/jsnotelog(\(.*\))$/this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'note', message: \1});/ge

"javascript warn log
"%s/jswarnlog(\(.*\))$/ApplicationLog.log(PROCESS_NAME,MODULE_NAME,FILENAME,FUNCTION_NAME,'warn',\1);/ge
"%s/jswarnlog(\(.*\))$/Logger.log({process: PROCESS_NAME, module: MODULE_NAME, file: FILENAME, function: FUNCTION_NAME, level: 'warn', message: \1});/ge
%s/jswarnlog(\(.*\))$/this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'warn', message: \1});/ge

"javascript error log
"%s/jserrorlog(\(.*\))$/ApplicationLog.log(PROCESS_NAME,MODULE_NAME,FILENAME,FUNCTION_NAME,'error',\1);/ge
"%s/jserrorlog(\(.*\))$/Logger.log({process: PROCESS_NAME, module: MODULE_NAME, file: FILENAME, function: FUNCTION_NAME, level: 'error', message: \1});/ge
%s/jserrorlog(\(.*\))$/this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'error', message: \1});/ge

"javascript crit log
"%s/jscritlog(\(.*\))$/Logger.log({process: PROCESS_NAME, module: MODULE_NAME, file: FILENAME, function: FUNCTION_NAME, level: 'crit', message: \1});/ge
%s/jscritlog(\(.*\))$/this.logger.log({file: FILENAME, function: FUNCTION_NAME, level: 'crit', message: \1});/ge

"javascript log debug macro (<ModuleName>,<FunctionName>,<Message>)
%s/jsdebugtm(\([^,]*\),\([^,]*\),\(.*\));/Log.log(process.argv0,\1,Path.basename(__filename),\2,'debug',\3);/ge

"javascript log error macro (<ModuleName>,<FunctionName>,<Message>)
%s/jserror(\([^,]*\),\([^,]*\),\(.*\));/Log.log(process.argv0,\1,Path.basename(__filename),\2,'error',\3);/ge

"javascript if-option: fill-item
%s/jsoptfill(\(\w\+\))/if(Options.\1 != null) item.\1 = Options.\1;/ge

"javascript function-argument check (argument)
%s/jsargcheck(\(\w\+\))/if(\1 == undefined){\r\t Log.log('fina', null, Path.basename(__filename), 'Fina_Purchase_Add', 'error','[Function argument: \\'\1\\'  not specified.]');\r\t_return[0] = -2;\r\t_return[1] += '[Function argument: \\'\1\\' not specified.]';\r}/ge

"javascript if-variable-undefined fill (variable,value)
%s/jsifundef(\(\w\+\),\([^)]\+\))/if(\1 == undefined){\r\t\1 = \2;\r}/ge

" if input_object.node.npm.<field> != null else ...
%s/pnn(\(\w\+\))$/if( input_object.node.npm.\1 != null ){\r\tpackage_json_object.\1 = input_object.node.npm.\1;\r} else if( input_object.\1 != null ){\r\tpackage_json_object.\1 = input_object.\1;\r} else{\r\tconsole.error('Error: can\\'t derive a value for the "\1" field from input object: %o', input_object);\r}/ge

" if this.<key> is <type> assign json_object.<key>
%s/kit(\(\w\+\),\(\w\+\))$/if( typeof(this.\1) === '\2' ){\r\t\t\tjson_object.\1 = this.\1;\r\t\t}/ge

"return property not correct type (<property>,<type>)
%s/rer(\(\w\+\),\(\w\+\))$/_return = [-X,'Error: property "\1" is not a \2.'];\r/ge

"file comment macro (<Filename>,<Description>)
%s/filecommenttm(\([^,]*\),\([^)]*\))/\/**\r*\t@file \1\r*\t@brief \2\r*\t@author Anadian\r*\t@license MIT License:\rMITlicensetm(2018,Canosw)\r*\//ge


"MIT license macro (<Year>,<Organization>)
%s/MITlicensetm(\([^,]*\),\([^)]*\))/\tCopyright \1 \2\r\tPermission is hereby granted, free of charge, to any person obtaining a copy of this \rsoftware and associated documentation files (the "Software"), to deal in the Software \rwithout restriction, including without limitation the rights to use, copy, modify, \rmerge, publish, distribute, sublicense, and\/or sell copies of the Software, and to \rpermit persons to whom the Software is furnished to do so, subject to the following \rconditions:\r\tThe above copyright notice and this permission notice shall be included in all copies \ror substantial portions of the Software.\r\tTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, \rINCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A \rPARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT \rHOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF \rCONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE \rOR THE USE OR OTHER DEALINGS IN THE SOFTWARE./ge

"gnu_make variable initialise and print (<VariableName>,<DefaultValue>)
%s/^mkvar(\([^,]*\),\(.*\))$/#\0\rifeq ($(origin \1),undefined)\r\1=\2\rendif #($(origin \1),undefined)\rifeq ($(VERBOSE),1)\r$(info \1:$(\1))\rendif #($(VERBOSE),1)\r/ge

%s/DPAMC(\([^,]*\),\([^)]*\))/C\\strcpy(DP\\ActionPads[actionpad].actioncodes[DreamPuff_Action_\1].\2code, ""); DP\\ActionPads[actionpad].actioncodes[DreamPuff_Action_\1].\2enabled = 1;/ge

%s/DPAM(\([^)]*\)/DPAMC(\1,primary)\rDPAMC(\1,secondary)\rDPAMC(\1,tertiary/ge

"goSUCC creates a success printf message for go testing files. (<message>,<additional printf terms>)
%s/goSUCC(\([^,]*\),\([^)]*\))$/log.Printf("Success: \1\\n",\2);/ge

"goFAIL creates a failure printf message for go testing files. (<message>,<additional printf terms>)
%s/goFAIL(\([^,]*\),\([^)]*\))$/log.Printf("Failure: \1\\n",\2);/ge

"C Safe Include(<Expression>,<IncludeStatement>)
%s/^CSI(\([^,]*\),\([^)]*\))/\/* \0 *\/\r#if \1\r#include \2\r#endif \/* \1 *\//ge

"PredefinedMacroTemplate
%s/^PMT_\([^(]*\)(\([^,]*\),\([^,]*\),\([^,]*\),\([^)]*\))/\/\/\0\r#if \5\r#define CNO_\1_\2 \3\r#define CNO_\1_NAME \4\r#define CNO_\1 CNO_\1_\2\r#endif \/\/\5/ge

"ConditionallyDefinedMacro
%s/^\/\/CDM(\([^,]*\),\(.*\))$/\0\r#if !defined(\1) \/\/p\r#define \1 \2 \/\/p\r#endif \/\/!defined(\1) \/\/p/ge

"Macro (<Condition>`<Name>`<Value>)
%s/^macro(\([^`]*\)`\([^`]*\)`\(.*\))$/\/* \0 *\/\r#if \1\r#define \2 \3\r#endif \/* \1 *\//ge

"%s/LLC\\/LowLevelConfig/ge
"%s/DP\\/DreamPuff_/ge
"%s/llcvm(\([^)]*\))/C\\sprintf(buffer, "\1=%d\\n", C\\LowLevelConfig.SECTION.\1);\r\t\tC\\fputs(buffer, configfile);/ge
"%s/llcnm(\([^,]*\),\([^)]*\))/if(C\\strcmp(name,"\2") == 0) pconfig->\1.\2 = C\\atoi(value);/ge

"Function wrapper macro
"%s/fwm(\([^)]*\))/#ifndef CNO_\1\r#if C\\H\\PREREQ\r#define CNO_\1(\.\.\.) \1(__VA_ARGS__)\r#else\r#define C\\\1(\.\.\.) C\\noop\r#endif \/\/C\\H\\PREREQ\r#endif \/\/CNO_\1/ge

"e\r -> error_report
"%s/e\\r/error_report/ge

"E\R -> ErrorReport
"%s/E\\R/ErrorReport/ge

%s/App\\/Application/ge
"%s/C\\/CNO_/ge
"%s/H\\/HAVE_/ge
"%s/A\\/ALLOW_/ge
"%s/CS\\/CNO_Setting_/ge
"%s/c\\/cno_/ge
"%s/\\s/_struct/ge
"%s/\\f/_func/ge
"%s/\\e/_enum/ge
"%s/\\ty/_type/ge
"%s/ON\\/Option_Name_/ge

" Expand f<BACKSLASH>r to function_return
%s/f\\r/function_return/ge

"C Header file template (Name)
%s/headertm(\([^)]*\))/#if !defined(\1)\r#define \1\r\r#if defined(__cplusplus)\rextern "C"{\r#endif \/* defined(__cplusplus) *\/\r\r\r\r#if defined(__cplusplus)\r}\r#endif \/* defined(__cplusplus) *\/\r\r#endif \/* !defined(\1) *\//ge
write!
