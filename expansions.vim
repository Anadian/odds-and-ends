%g/.*\/\/p$/de

"C-JSON Object set string property (<Object>,<Property>)
%s/cjsonsetstring(\([a-z0-9_]*\),\([a-z_]*\))/JSON_Status set_\2_return = json_object_set_string(\1_object, "\2", (*environment).\1.\2);/ge

"c safe xdg getenv with default macro (<VariableName>,<PropertyName>,<DefaultValue>)
%s/^xdg(\([A-Z_]*\),\([a-z_]*\),\([^)]*\))/if(getenv("\1") != NULL) C\\String_Copy(\&((*environment_xdg).\2), getenv("\1"));\relse C\\String_Copy(\&((*environment_xdg).\2), "\3");/ge

"javascript function macro (<FunctionName>,<Arguments>)
%s/jsfunctionmacro(\([^,]*\),\([^)]*\))/function \1(\2){\r\tconsole.log("%s: ", arguments.callee.name, \2);\r\tvar _return = [0,null];\r\t\r\tconsole.log("%s returned: ", arguments.callee.name, _return);\r\treturn _return;\r}/ge

"javascript debug log
%s/jsdebuglog(\(.*\))$/Log.log(PROCESS_NAME,MODULE_NAME,FILENAME,FUNCTION_NAME,'debug',\1);/ge

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

"file comment macro (<Filename>,<Description>)
%s/filecommenttm(\([^,]*\),\([^)]*\))/\/**\r*\t@file \1\r*\t@brief \2\r*\t@author Anadian\r*\t@license MIT License:\rMITlicensetm(2018,Canosw)\r*\//ge


"MIT license macro (<Year>,<Organization>)
%s/MITlicensetm(\([^,]*\),\([^)]*\))/\tCopyright \1 \2\r\tPermission is hereby granted, free of charge, to any person obtaining a copy of this \rsoftware and associated documentation files (the "Software"), to deal in the Software \rwithout restriction, including without limitation the rights to use, copy, modify, \rmerge, publish, distribute, sublicense, and\/or sell copies of the Software, and to \rpermit persons to whom the Software is furnished to do so, subject to the following \rconditions:\r\tThe above copyright notice and this permission notice shall be included in all copies \ror substantial portions of the Software.\r\tTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, \rINCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A \rPARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT \rHOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF \rCONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE \rOR THE USE OR OTHER DEALINGS IN THE SOFTWARE./ge

"gnu_make variable initialise and print (<VariableName>,<Value>)
%s/^mkvar(\([^,]*\),\(.*\))$/#\0\rifeq ($(origin \1),undefined)\r\1=\2\rendif #($(origin \1),undefined)\rifeq ($(VERBOSE),1)\r$(info \1:$(\1))\rendif #($(VERBOSE),1)\r/ge

%s/DPAMC(\([^,]*\),\([^)]*\))/C\\strcpy(DP\\ActionPads[actionpad].actioncodes[DreamPuff_Action_\1].\2code, ""); DP\\ActionPads[actionpad].actioncodes[DreamPuff_Action_\1].\2enabled = 1;/ge

%s/DPAM(\([^)]*\)/DPAMC(\1,primary)\rDPAMC(\1,secondary)\rDPAMC(\1,tertiary/ge

"C Safe Include(<Expression>,<IncludeStatement>)
%s/^CSI(\([^,]*\),\([^)]*\))/\/* \0 *\/\r#if \1\r#include \2\r#endif \/* \1 *\//ge

"PredefinedMacroTemplate
%s/^PMT_\([^(]*\)(\([^,]*\),\([^,]*\),\([^,]*\),\([^)]*\))/\/\/\0\r#if \5\r#define CNO_\1_\2 \3\r#define CNO_\1_NAME \4\r#define CNO_\1 CNO_\1_\2\r#endif \/\/\5/ge

"ConditionallyDefinedMacro
%s/^\/\/CDM(\([^,]*\),\(.*\))$/\0\r#if !defined(\1) \/\/p\r#define \1 \2 \/\/p\r#endif \/\/!defined(\1) \/\/p/ge

"Macro (<Condition>`<Name>`<Value>)
%s/^macro(\([^`]*\)`\([^`]*\)`\(.*\))$/\/* \0 *\/\r#if \1\r#define \2 \3\r#endif \/* \1 *\//ge

%s/LLC\\/LowLevelConfig/ge
%s/DP\\/DreamPuff_/ge
%s/llcvm(\([^)]*\))/C\\sprintf(buffer, "\1=%d\\n", C\\LowLevelConfig.SECTION.\1);\r\t\tC\\fputs(buffer, configfile);/ge
%s/llcnm(\([^,]*\),\([^)]*\))/if(C\\strcmp(name,"\2") == 0) pconfig->\1.\2 = C\\atoi(value);/ge

"Function wrapper macro
%s/fwm(\([^)]*\))/#ifndef CNO_\1\r#if C\\H\\PREREQ\r#define CNO_\1(\.\.\.) \1(__VA_ARGS__)\r#else\r#define C\\\1(\.\.\.) C\\noop\r#endif \/\/C\\H\\PREREQ\r#endif \/\/CNO_\1/ge

%s/App\\/Application/ge
%s/C\\/CNO_/ge
%s/H\\/HAVE_/ge
%s/A\\/ALLOW_/ge
%s/CS\\/CNO_Setting_/ge
%s/c\\/cno_/ge
%s/\\s/_struct/ge
%s/\\f/_func/ge
%s/\\e/_enum/ge
%s/\\ty/_type/ge
%s/ON\\/Option_Name_/ge

" Expand f<BACKSLASH>r to function_return
%s/f\\r/function_return/ge

"C Header file template (Name)
%s/headertm(\([^)]*\))/#if !defined(\1)\r#define \1\r\r#if defined(__cplusplus)\rextern "C"{\r#endif \/* defined(__cplusplus) *\/\r\r\r\r#if defined(__cplusplus)\r}\r#endif \/* defined(__cplusplus) *\/\r\r#endif \/* !defined(\1) *\//ge
write!
