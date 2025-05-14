-- Standard NVIM startup
if( vim.fn.has('win32') == 1 ) then
	vim.cmd.set( 'runtimepath^=~\\.vim_runtime runtimepath+=~\\.vim_runtime\\after' );
	vim.cmd.let( '&packpath = &runtimepath' );
	vim.cmd.source( '~\\.vimrc' );
	print('Windows mode.');
else
	vim.cmd.set( 'runtimepath^=~/.vim runtimepath+=~/.vim/after' );
	vim.cmd.let( '&packpath = &runtimepath' );
	vim.cmd.source( '~/.vimrc' );
end
-- paq-nvim as package manager
require('paq'){
	'savq/paq-nvim',
	'hjson/vim-hjson',
	{ 'neoclide/coc.nvim', branch = 'release' },
	'cheap-glitch/vim-v'
};
