" #Settings
" Disable vi-compatibilty settings
set nocompatible
" Make buffers 'hidden' when inactive so we can change buffer without writing.
set hid
" Set the number of lines be always shown when moving the window with j/k.
set so=4
" Use UTF-8 encoding.
set encoding=utf8
" Use Unix as the standard file type, then DOS, then old-school Macintosh.
set ffs=unix,dos,mac
" Make tabs 4 spaces in width.
set shiftwidth=4
" Make tabs work more intuitively.
set shiftround
" Make tabs 4 spaces in width.
set tabstop=4
" Default to showing line numbers on the side.
set number
" Disable the '--more--' prompts when executing batch commands or listing things.
set nomore
" Ignore case if search pattern is all lowercase,case-sensitive otherwise.
" set smartcase
" Disable audible error bells.
set noerrorbells
" Diable visual error bells.
set novisualbell
" Always show cursor position in status bar.
set ruler
" Don't underline the current line.
set nocursorline
" Always show at least 2 status lines.
set laststatus=2
" Always show current mode.
set showmode
" Automatically tab to the current indentation when creating a new line.
set autoindent
" Automatically reread files from the disk when they've been updated.
set autoread
" Enable syntax highlighting.
syntax enable
" Enable persistent undo.
try
    set undodir=~/.vim_runtime/undodir
    set undofile
catch
endtry

" #Mappings
" Opt+[ Previous Buffer
nnoremap “ :bp<cr>
" Opt+] Next Buffer
nnoremap ‘ :bn<cr>
" Opt+f First Buffer
nnoremap ƒ :bfirst<cr>
" Opt+l Last Buffer
nnoremap ¬ :blast<cr>
" Opt+\ List Buffers
nnoremap « :ls<cr>
" Opt+, Move to the left window.
nnoremap ≤ <C-W>h
" Opt+. Move to the right window.
nnoremap ≥ <C-W>l
" Opt+/ Split into vertical windows.
nnoremap ÷ <C-W>v
" Close current window.
nnoremap µ :close<cr>
" Makes semi-colon work like a colon.
nnoremap ; :
" Ensures that Control+; still results in a normal semi-colon.
nnoremap <C>; ;
" Opt+w Write buffer to file.
nnoremap ∑ :write!<cr>
" Add command 'SudoWrite' to force writing of the current buffer, overiding permissions.
command! SudoWrite w !sudo tee % > /dev/null
" Opt+Shift+W Execute 'SudoWrite' command.
nnoremap „ :SudoWrite<cr>
" Add command 'Expand' to source '%s/<search>/<replace>/ge' style macros from ~/.expansions
command! Expand so ~/.expansions
" Opt+r Execute 'Expand' command.
nnoremap ® :Expand<cr>
" Move up one window-width-dependent line like a gui text editor.
nnoremap ∆ gj
" Move down one window-width-dependent line like a gui text editor.
nnoremap ˚ gk
" Opt+Shift+t Replace the word under the cursor with 'true'; useful for JSON files.
nnoremap ˇ cetrue<esc>
" Opt+Shift+f Replace the word under the cursor with 'false'; useful for JSON files.
nnoremap Ï cefalse<esc>
" Opt+Shift+n Replace the word under the cursor with 'null'; useful for JSON files.
nnoremap ˜ cenull<esc>
" Disable Control+u while in insert mode to prevent accidental content loss.
inoremap <c-u> <esc>
" Allow multiple indentation/deindentation in visual mode.
vnoremap < <gv
vnoremap > >gv

