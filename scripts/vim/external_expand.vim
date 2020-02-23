if( has('win32') )
	argdo! so ~\.expansions | write!
else
	argdo! so ~/.expansions | write!
endif
quit!
