#!/usr/bin/env lua
if( printf == nil) then
	function printf( format_string, ... )
		print( string.format( format_string, ... ) );
	end
end

if( arg ~= nil ) then
	function string:at( index )
		return self:sub( index, index );
	end
	DIRECTORY_SEPERATOR = package.config:at( 1 );
	PATH_SEPERATOR = package.config:at( 3 );
	REPLACEMENT_TOKEN = package.config:at( 5 );
	function dirname( path_string )
		local match_pattern = string.format( '(.+%s).+%%.lua$', DIRECTORY_SEPERATOR );
		print( match_pattern );
		local _return = string.match( path_string, match_pattern );
		return _return;
	end
	function appendPackagePath( new_directory )
		local inner_format = string.format( '%s%%s%s.lua', PATH_SEPERATOR, REPLACEMENT_TOKEN );
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
require('slot-table');

slot_table = SlotTable:new();
slot_table[1] = 1;
print( 'slot_table:exists( 1 ) = ', slot_table:exists( 1 ) );
st2 = SlotTable:new( { 1, 2, 3, 4, 5 } );
print( 'st2.exists( 5 ) = ', st2:exists( 5 ) );
st = SlotTable:new();
printf( 'st = %s', st );
--index = st:exists( buffer_pointer );
--printf( 'index = %d', index );
st:add( 6 );
st:add( 7 );
print( st );

