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
	function table.print( input_table )
		printf( 'Printing table#%d:', #input_table );
		for k,v in pairs( input_table ) do
			printf( '\t%s: %s', k, v );
		end
		print( 'Done printing table.' );
	end
end
if( path == nil ) then
	path = {
		DIRECTORY_SEPARATOR = package.config:at( 1 ),
		PATH_SEPARATOR = package.config:at( 3 ),
		REPLACEMENT_TOKEN = package.config:at( 5 ),
		getScriptPath = function()
			local _return = '';
			if( arg[0] ~= nil ) then
				_return = arg[0];
			else
				_return = debug.getinfo( 1 ).short_src;
			end
			return _return;
		end,
		join = function( ... )
			return table.concat( { ... }, path.DIRECTORY_SEPARATOR );
		end,
		dirname = function( path_string )
			local match_pattern = string.format( '(.+%s).+%%.lua$', path.DIRECTORY_SEPARATOR );
			print( match_pattern );
			local _return = string.match( path_string, match_pattern );
			return _return;
		end
	};
end
if( package.appendPackagePath == nil ) then
	function package.appendPackagePath( new_directory )
		local inner_format = string.format( '%s%%s%s.lua', path.PATH_SEPARATOR, path.REPLACEMENT_TOKEN );
		print( inner_format );
		local outer_string = string.format( inner_format, new_directory );
		package.path = package.path .. outer_string;
	end;
end
if( SCRIPT_PATH == nil ) then
	SCRIPT_PATH = path.getScriptPath();
	script_directory = path.dirname( SCRIPT_PATH );
	if( script_directory ~= nil ) then
		package.appendPackagePath( script_directory );
	end
	printf( 'scriptpath %s\ndirectory %s\npackage config#%d=%spath=%s\ncpath=%s', scriptpath, scriptdirectory, #package.config, package.config, package.path, package.cpath );
end
function Main()
	printf( path.join( 'a', 'b', 'c' ) ); -- => 'a/b/c'
	local debug_table = debug.getinfo( 1 );
	if( debug_table ~= nil ) then
		printf( 'debug_table#%d is not null', #debug_table );
		table.print( debug_table );
	end
end
--Main();
