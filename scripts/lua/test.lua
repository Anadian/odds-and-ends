#!/usr/bin/env lua
if( printf == nil) then
	function printf( format_string, ... )
		print( string.format( format_string, ... ) );
	end
end
if( string.at == nil ) then
	function string:at( index )
		return self:sub( index, index );
	end
end
if( table.print == nil ) then
	function table:print()
		for k,v in pairs( self ) do
			printf( '%s: %s', k, v );
		end
	end
end
if( arg ~= nil ) then
	printf( 'arg#%d is not null', #arg );
	arg:print();
	DIRECTORY_SEPARATOR = package.config:at( 1 );
	PATH_SEPARATOR = package.config:at( 3 );
	REPLACEMENT_TOKEN = package.config:at( 5 );
	function dirname( path_string )
		local match_pattern = string.format( '(.+%s).+%%.lua$', DIRECTORY_SEPARATOR );
		print( match_pattern );
		local _return = string.match( path_string, match_pattern );
		return _return;
	end
	function appendPackagePath( new_directory )
		local inner_format = string.format( '%s%%s%s.lua', PATH_SEPARATOR, REPLACEMENT_TOKEN );
		print( inner_format );
		local outer_string = string.format( inner_format, new_directory );
		package.path = package.path .. outer_string;
	end
	scriptpath = arg[0];
	scriptdirectory = dirname( scriptpath );
	if( scriptdirectory ~= nil ) then
		appendPackagePath( scriptdirectory );
	end
	printf( 'scriptpath %s\ndirectory %s\npackage config#%d=%spath=%s\ncpath=%s', scriptpath, scriptdirectory, #package.config, package.config, package.path, package.cpath );
end
require('bedrock');
require('slot-table');
printf( path.join( 'a', 'b', 'c' ) );
