#include <stdio.h> //printf
#include <stdlib.h> //getenv, atoi
#include <string.h> //strstr

int main(int argc, char *argv[]){
	int lines;
	int cols;
	int helpflag;
	helpflag = 0;
	char sepstr[256];
	char *psepstr = sepstr;
	char *linesstr;
	char *colsstr;
	linesstr = getenv("LINES");
	if(linesstr != NULL){
		lines = atoi(linesstr);
	} else{
		lines = 24;
	}
	colsstr = getenv("COLUMNS");
	if(colsstr != NULL){
		cols = atoi(colsstr);
	} else{
		cols = 80;
	}
	strcpy(psepstr, "/");
	//printf("psepstr: %s\n", psepstr);
	int i;
	for(i = 1; i < argc; i++){
		//printf("argv[%d]: %s\n", i, argv[i]);
		if( (strcmp(argv[i], "-h") == 0) || (strcmp(argv[i], "--help") == 0) ){
			printf("Sep tool: the simple separator\nUsage: sep [options]\nBy default sep looks for 'LINES' and 'COLUMNS' in the environment; if it doesn't find them, it defaults to 24 and 80, respectively.\nOptions:\n\t-h --help: print this help message.\n\t-lines=X: forces the number of lines (rows) sep prints to be X instead of 'LINES' (in the environment) or 24, as the default, if 'LINES' is not found.\n\t-cols=X: force the number of columns sep prints to be X instead of 'COLUMNS' (in the environment) or 80, as the default, if 'COLUMNS' is not found.\n\t-sepstr=X: modify the string sep uses to fill the space, defaults to \"/\", where X is the new string. If the string's length is less than cols, the string will be printed multiple times.\n");
			helpflag = 1;
		} else if(strstr(argv[i], "-lines=") != NULL){
			char buffer[strlen(argv[i]) - strlen("-lines=")];
			int j;
			for(j = 0; j < (strlen(argv[i]) - strlen("-lines=")); j++){
				buffer[j] = argv[i][strlen("-lines=")+j];
			}
			char *pbuffer = buffer;
			lines = atoi(pbuffer);
		} else if(strstr(argv[i], "-cols=") != NULL){
			char buffer[strlen(argv[i]) - strlen("-cols=")];
			int j;
			for(j = 0; j < (strlen(argv[i]) - strlen("-cols=")); j++){
				buffer[j] = argv[i][strlen("-cols=")+j];
			}
			char *pbuffer = buffer;
			cols = atoi(pbuffer);
		} else if(strstr(argv[i], "-sepstr=") != NULL){
			printf("strlen(argv[i]): %d\tstrlen(\"-sepstr=\"): %d\n", strlen(argv[i]), strlen("-sepstr="));
			char buffer[(strlen(argv[i]) - strlen("-sepstr="))+1];
			int j;
			for(j = 0; j < ((strlen(argv[i]) - strlen("-sepstr="))+1); j++){
				buffer[j] = argv[i][strlen("-sepstr=")+j];
				printf("buffer[%d]: %c\n", j, buffer[j]);
			}
			printf("sizeof buffer: %d buffer length: %d buffer: %s\n", sizeof(buffer), strlen(buffer), buffer);
			char *pbuffer = buffer;
			printf("pbuffer: %s\n", pbuffer);
			strcpy(psepstr, pbuffer);
			printf("psepstr: %s\n", psepstr);
		} else{
			printf("Argument not recognised: %d %s\n", i, argv[i]);
		}
	}
	if(!helpflag){
		int j;
		for(i = 0; i < lines; i++){
			for(j = 0; j < cols; j++){
				printf("%s", psepstr);
			}
			printf("\n");
		}
	}
	return 0;
}
