set nocompatible
nnoremap “ :bp<cr>
nnoremap ‘ :bn<cr>
nnoremap ƒ :bfirst<cr>
nnoremap ¬ :blast<cr>
nnoremap « :ls<cr>
nnoremap ≤ <C-W>h
nnoremap ≥ <C-W>l
nnoremap ÷ <C-W>v
nnoremap µ :close<cr>
nnoremap ; :
nnoremap <C>; ;
nnoremap ∑ :write!<cr>
command! SudoWrite w !sudo tee % > /dev/null
nnoremap „ :SudoWrite<cr>
command! Expand so ~/.expansions
nnoremap ® :Expand<cr>
nnoremap ∆ gj
nnoremap ˚ gk
nnoremap ˇ cetrue<esc>
nnoremap Ï cefalse<esc>
nnoremap ˜ cenull<esc>
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

