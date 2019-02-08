" #Settings
" ##Essentials
" Disable vi-compatibilty settings
set nocompatible
" Make buffers 'hidden' when inactive so we can change buffer without writing.
set hid
" Automatically reread files from the disk when they've been updated.
set autoread
" Lazy redraw.
"set lazyredraw
" Vim info file?
"set viminfo
" Set the number of lines be always shown when moving the window with j/k.
set scrolloff=4 "so
" ##File types and encoding.
" Use UTF-8 encoding.
scriptencoding utf-8
set encoding=utf8
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1
" Use Unix as the standard file type, then DOS, then old-school Macintosh.
set ffs=unix,dos,mac
" ##Indentation
" Automatically tab to the current indentation when creating a new line.
set autoindent
set smartindent     " indent when
" Make auto indentation 4 spaces in width.
set shiftwidth=4
" Make tabs 4 spaces in width.
set tabstop=4
" Make back space remove 4 spaces??
set softtabstop=4
" Make tabs work more intuitively.
set shiftround
" ##User Inteface
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
" Show file in title bar.
set title
" Always show cursor position in status bar.
set ruler
" Don't underline the current line.
set nocursorline
" Always show at least 2 status lines.
set laststatus=2
" Always show current mode.
set showmode
" Show command and visual-selection information.
set showcmd
" Disable line wrappng.
"set nowrap
" Allow backspace over any thing while in insert mode.
set backspace=indent,eol,start
" Enable proper mouse support.
"set mouse=a
" Enable proper clipboard support.
set clipboard=unnamed
" Show invisible characters.
"set list
" Make keyboard fast?
"set ttyfast
"set timeout timeoutlen=1000 ttimeoutlen=50
" Folding rules?
" Enable folding.
"set foldenable
" Add a fold column.
"set foldcolumn=2
" Recognize {{{ and }}} fold markers.
"set foldmethod=marker
" Default folding level
"set foldlevelstart=99
" Enable syntax highlighting.
syntax enable
" Enable persistent undo.
try
    set undodir=~/.vim_runtime/undodir
    set undofile
catch
endtry

" #Commands
" Add command 'SudoWrite' to force writing of the current buffer, overiding permissions.
command! SudoWrite w !sudo tee % > /dev/null
" Add command 'Expand' to source '%s/<search>/<replace>/ge' style macros from ~/.expansions
command! Expand so ~/.expansions

" #Universal remaps
" Disable Control+u while in insert mode to prevent accidental content loss.
inoremap <c-u> <esc>
" Allow multiple indentation/deindentation in visual mode.
vnoremap < <gv
vnoremap > >gv


" #Mappings
if(has("macunix"))
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
" Opt+m Close current window.
nnoremap µ :close<cr>
" Makes semi-colon work like a colon.
nnoremap ; :
" Ensures that Control+; still results in a normal semi-colon.
nnoremap <C>; ;
" Opt+w Write buffer to file.
nnoremap ∑ :write!<cr>
" Opt+Shift+W Execute 'SudoWrite' command.
nnoremap „ :SudoWrite<cr>
" Opt+r Execute 'Expand' command.
nnoremap ® :Expand<cr>
" Opt+k Move up one window-width-dependent line like a gui text editor.
nnoremap ˚ gk
" Opt+j Move down one window-width-dependent line like a gui text editor.
nnoremap ∆ gj
" Opt+Shift+t Replace the word under the cursor with 'true'; useful for JSON files.
nnoremap ˇ cetrue<esc>
" Opt+Shift+f Replace the word under the cursor with 'false'; useful for JSON files.
nnoremap Ï cefalse<esc>
" Opt+Shift+n Replace the word under the cursor with 'null'; useful for JSON files.
nnoremap ˜ cenull<esc>
elseif(has("linux"))
" Alt+[ Previous Buffer
nnoremap <A-[> :bp<cr>
" Alt+] Next Buffer
nnoremap <A-]> :bn<cr>
" Alt+f First Buffer
nnoremap ƒ :bfirst<cr>
" Alt+l Last Buffer
nnoremap ¬ :blast<cr>
" Alt+\ List Buffers
nnoremap « :ls<cr>
" Alt+, Move to the left window.
nnoremap ≤ <C-W>h
" Alt+. Move to the right window.
nnoremap ≥ <C-W>l
" Alt+/ Split into vertical windows.
nnoremap ÷ <C-W>v
" Alt+m Close current window.
nnoremap µ :close<cr>
" Makes semi-colon work like a colon.
nnoremap ; :
" Ensures that Control+; still results in a normal semi-colon.
nnoremap <C>; ;
" Alt+w Write buffer to file.
nnoremap ∑ :write!<cr>
" Alt+Shift+W Execute 'SudoWrite' command.
nnoremap „ :SudoWrite<cr>
" Alt+r Execute 'Expand' command.
nnoremap ® :Expand<cr>
" Alt+k Move up one window-width-dependent line like a gui text editor.
nnoremap ˚ gk
" Alt+j Move down one window-width-dependent line like a gui text editor.
nnoremap ∆ gj
" Alt+Shift+t Replace the word under the cursor with 'true'; useful for JSON files.
nnoremap ˇ cetrue<esc>
" Alt+Shift+f Replace the word under the cursor with 'false'; useful for JSON files.
nnoremap Ï cefalse<esc>
" Alt+Shift+n Replace the word under the cursor with 'null'; useful for JSON files.
nnoremap ˜ cenull<esc>

endif
" #Helpful syntax notes
" <nop> No operation
