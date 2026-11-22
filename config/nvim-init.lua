-- Standard NVIM startup
if( vim.fn.has('win32') == 1 ) then
	vim.cmd.set( 'runtimepath^=~\\.vim_runtime runtimepath+=~\\.vim_runtime\\after' );
	vim.cmd.let( '&packpath = &runtimepath' );
	vim.cmd.source( '~\\.vimrc' );
	DIRECTORY_SEPARATOR = '\\';
	print('Windows mode.');
else
	vim.cmd.set( 'runtimepath^=~/.vim runtimepath+=~/.vim/after' );
	vim.cmd.let( '&packpath = &runtimepath' );
	vim.cmd.source( '~/.vimrc' );
	DIRECTORY_SEPARATOR = '/';
end
-- paq-nvim as package manager
require('paq'){
	'savq/paq-nvim',
	'hjson/vim-hjson',
	{ 'neoclide/coc.nvim', branch = 'release' },
	'cheap-glitch/vim-v',
	'mfussenegger/nvim-dap',
	'dzfrias/arena.nvim'
};
-- Lua stuff
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
if( table.sub == nil ) then
	function table.splice( input_table, lower, upper )
		table.print( input_table );
		printf( 'lower=%d upper=%d', lower, upper );
		local _return = { table.unpack( input_table, lower, upper ) };
		return _return;
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
vim.g.PLUGINS_PATH = path.join( vim.fn.stdpath('data'), 'site', 'pack', 'paqs', 'start' );
vim.g.editorconfig = false;

vim.cmd.let( 'g:xml_syntax_folding=1' );
vim.cmd.autocmd( 'FileType xml setlocal foldmethod=syntax' );
-- DebugOpts
vim.api.nvim_create_user_command( 'DebugOpts', function(opts)
	printf( 'opts.args=%s', opts.args );
	table.print( opts );
end, { nargs = '*' });
-- GrepEdit
function grep_edit( input_args )
	local cmd = 'grep -rle ' .. input_args;
	print( 'cmd=' .. cmd );
	local handle = io.popen(cmd);
	if( handle ) then
		for filename in handle:lines() do
			print( 'Opening ' .. filename );
			vim.cmd('edit ' .. filename);
		end
	end
	handle:close();
	return;
end
vim.api.nvim_create_user_command( 'GrepEdit', function(opts)
	grep_edit( opts.args );
end, { nargs = 1 } );
-- Editconfig
vim.api.nvim_create_user_command( 'EditConfig', function(opts)
	vim.cmd('edit ' .. vim.fn.stdpath('config') .. path.DIRECTORY_SEPARATOR .. 'init.lua' );
end, { nargs = 0 } );

--vim.cmd.autocmd( 'BufEnter,BufRead *.xml,*.html,*.xhtml,*.CT source ' .. path.join( vim.g.PLUGINS_PATH, 'XML-Folding', 'plugin', 'XMLFolding.vim' ) );
require("arena").setup();
