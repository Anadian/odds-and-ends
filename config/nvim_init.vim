if(has('win32') == 1)
	set runtimepath^=~\.vim_runtime runtimepath+=~\.vim_runtime\after
	let &packpath = &runtimepath
	so ~\.vimrc
	echom 'Windows mode.'
else
	set runtimepath^=~/.vim runtimepath+=~/.vim/after
	let &packpath = &runtimepath
	so ~/.vimrc
endif
