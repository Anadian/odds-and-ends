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
"set clipboard=unnamed
" Removing the annoying auto-comment on lines following a commented line.
" "fo format options
autocmd! BufEnter * set fo-=r fo-=o
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

"From Vim Wiki: adds a :Hexmode command to toggle hex editing.
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" #Universal remaps
" Disable Control+u while in insert mode to prevent accidental content loss.
inoremap <c-u> <esc>
" Allow multiple indentation/deindentation in visual mode.
vnoremap < <gv
vnoremap > >gv
" Makes semi-colon work like a colon.
nnoremap ; :
" Ensures that Control+; still results in a normal semi-colon.
nnoremap <C-;> ;
"Quickly toggle :Hexmode
nnoremap <C-H> :Hexmode<cr>

" #Mappings
if(has('macunix'))
" Opt+; Normal Semicolon Function
nnoremap … ;
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
elseif(has("unix") && !has("gui_running"))
"	let s:sh_command = 'ps -o ' . shellescape('command=') . ' -p $(ps -o ' . shellescape('ppid=') . ' -p $$)'
"	echomsg s:sh_command
"	let s:terminal_emulator_output = system( s:sh_command );
"	echomsg s:terminal_emulator_output
" Alt+[ Previous Buffer
nnoremap <M-[> :bp<cr>
" Alt+] Next Buffer
nnoremap <M-]> :bn<cr>
" Alt+f First Buffer
nnoremap <M-f> :bfirst<cr>
" Alt+l Last Buffer
nnoremap <M-l> :blast<cr>
" Alt+\ List Buffers
nnoremap <M-\> :ls<cr>
" Alt+, Move to the left window.
nnoremap <M-,> <C-W>h
" Alt+. Move to the right window.
nnoremap <M-.> <C-W>l
" Alt+/ Split into vertical windows.
nnoremap <M-/> <C-W>v
" Alt+m Close current window.
nnoremap <M-m> :close<cr>
" Alt+w Write buffer to file.
nnoremap <M-w> :write!<cr>
" Alt+Shift+W Execute 'SudoWrite' command.
nnoremap <M-W> :SudoWrite<cr>
" Alt+r Execute 'Expand' command.
nnoremap <M-r> :Expand<cr>
" Alt+k Move up one window-width-dependent line like a gui text editor.
nnoremap <M-k> gk
" Alt+j Move down one window-width-dependent line like a gui text editor.
nnoremap <M-j> gj
" Alt+Shift+t Replace the word under the cursor with 'true'; useful for JSON files.
nnoremap <M-T> cetrue<esc>
" Alt+Shift+f Replace the word under the cursor with 'false'; useful for JSON files.
nnoremap <M-F> cefalse<esc>
" Alt+Shift+n Replace the word under the cursor with 'null'; useful for JSON files.
nnoremap <M-N> cenull<esc>
" Alt+[ Previous Buffer
nnoremap <esc>[ :bp<cr>
" Alt+] Next Buffer
nnoremap <esc>] :bn<cr>
" Alt+f First Buffer
nnoremap <esc>f :bfirst<cr>
" Alt+l Last Buffer
nnoremap <esc>l :blast<cr>
" Alt+\ List Buffers
nnoremap <esc>\ :ls<cr>
" Alt+, Move to the left window.
nnoremap <esc>, <C-W>h
" Alt+. Move to the right window.
nnoremap <esc>. <C-W>l
" Alt+/ Split into vertical windows.
nnoremap <esc>/ <C-W>v
" Alt+m Close current window.
nnoremap <esc>m :close<cr>
" Alt+w Write buffer to file.
nnoremap <esc>w :write!<cr>
" Alt+Shift+W Execute 'SudoWrite' command.
nnoremap <esc>W :SudoWrite<cr>
" Alt+r Execute 'Expand' command.
nnoremap <esc>r :Expand<cr>
" Alt+k Move up one window-width-dependent line like a gui text editor.
nnoremap <esc>k gk
" Alt+j Move down one window-width-dependent line like a gui text editor.
nnoremap <esc>j gj
" Alt+Shift+t Replace the word under the cursor with 'true'; useful for JSON files.
nnoremap <esc>T cetrue<esc>
" Alt+Shift+f Replace the word under the cursor with 'false'; useful for JSON files.
nnoremap <esc>F cefalse<esc>
" Alt+Shift+n Replace the word under the cursor with 'null'; useful for JSON files.
nnoremap <esc>N cenull<esc>
else
"Probably Mac system-Vim
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
endif
" #Helpful syntax notes
" <nop> No operation
" Use :scriptnames to see all scripts that have been sourced in the order they were sourced
" Control+l forces redrawing of the screen.
