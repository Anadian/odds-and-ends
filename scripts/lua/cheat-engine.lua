if syntaxcheck then return end
if memrec then print( 'memrec:', memrec) end
if( cheatEngineIs64Bit() == true ) then
	ce_bits = '64-bit';
else
	ce_bits = '32-bit';
end
printf( 'CheatEngine v%s (%s) directory: %s', getCEVersion(), ce_bits, getCheatEngineDir() );
