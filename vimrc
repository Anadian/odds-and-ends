set nocompatible
nnoremap ˚ :bp<cr>
nnoremap ∆ :bn<cr>
nnoremap ˙ :bfirst<cr>
nnoremap ¬ :blast<cr>
nnoremap ≤ <C-W>h
nnoremap ≥ <C-W>l
nnoremap ÷ <C-W>v
nnoremap œ :close<cr>
nnoremap ; :
nnoremap <C>; ;
nnoremap ∑ :write!<cr>
command! SudoWrite w !sudo tee % > /dev/null
nnoremap „ :SudoWrite<cr>
set hid
set so=4
set encoding=utf8
set shiftwidth=4
set shiftround
set tabstop=4
set number
set nomore
set noerrorbells
set ruler
set nocursorline
set laststatus=2
set autoindent
set autoread
syntax enable
command! Expand so ~/.expansions

