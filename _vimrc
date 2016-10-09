﻿set nocompatible	"disable backwards-compatible with vi

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

set backup " make backup files
set backupdir=c:/temp " where to put backup files

"If you search for an all-lowercase string your search will be case-insensitive, but if one or more characters is uppercase the search will be case-sensitive.
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to                  "    shiftwidth, not tabstop

set backspace=indent,eol,start                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set showmatch     " set show matching parenthesis
set incsearch     " show search matches as you type
set visualbell		" Silence the bell, use a flash instead
set showcmd			" Show (partial) command in status line
set showmode
set wildmenu
set wildmode=list:longest,full



" Handle long lines
set nowrap " don't wrap lines
map <F2> <Esc>:set nowrap<CR>
map <S-F2> <Esc>:set wrap<CR>
nnoremap j gj
nnoremap k gk
"set colorcolumn=85	"show a colored column at 85 characters (so I can see when I write a too-long line of code)
set pastetoggle=<F5>	"Vim will switch to paste mode, disabling all kinds of smartness and just pasting a whole buffer of text. When in paste-mode auto indent will be turned off.

set nu
set ruler
set guioptions+=b
set guioptions-=T

set paste

set cursorline cursorcolumn

colorscheme xoria256

" set the menu & the message to English
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set fileencoding=utf-8
set encoding=utf-8
set tenc=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"language message zh_CN.UTF-8

filetype plugin on

if has("autocmd") && exists("+omnifunc")
autocmd Filetype *
\ if &omnifunc == "" |
\ setlocal omnifunc=syntaxcomplete#Complete |
\ endif
endif

" statusline
set laststatus=2
set statusline=%2*%n%m%r%h%w%*\ %F\ %1*[FORMAT=%2*%{&ff}:%{&fenc!=''?&fenc:&enc}%1*]\ [TYPE=%2*%Y%1*]\ [COL=%2*%03v%1*]\ [ROW=%2*%03l%1*/%3*%L(%p%%)%1*]\    
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=peru
  elseif a:mode == 'r'
    hi statusline guibg=blue
  else
    hi statusline guibg=black
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=orange guifg=white
hi statusline guibg=black

hi User1 guifg=gray
hi User2 guifg=red
hi User3 guifg=white
"hi User5 guibg=#C2BFA5 guifg=#666666 

" font
set guifont=Courier\ New:h11:cANSI
set guifontwide=Fixedsys:12:cANSI
"\ Consolas\ Hybrid:h10


" Maps
"nmap <tab> V>
"nmap <s-tab> V<
"vmap <tab> >gv
"vmap <s-tab> <gv

map <F10> <Esc>:tabnew<CR>

" clear highlighted searches
" nmap <silent> ,/ :nohlsearch<CR>
"
function ToggleHLSearch() 
	if &hls
		set nohls 
	else
		set hls 
	endif 
endfunction

nmap <silent> <leader><space> <Esc>:call ToggleHLSearch()<CR>

" Quickly edit/reload the vimrc file
"nmap <silent> <leader>ev :e $MYVIMRC<CR> 
"nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Abbreviations
abbreviate #b /**********************
abbreviate #e **********************/
"iabbrev pcode <p style="text-indent:2em"><code class="inset"></code></p>
"iabbrev icode <code class="inset">!cursor!</code><Esc>:call search('!cursor!','b')<cr>cf!
cabbrev h tab h

" Template
autocmd! BufNewFile * silent! 0r $VIM/vimfiles/skel/Template.%:e

" Fold
set foldmethod=marker
set foldcolumn=0

" Show invisible characters
set list
set listchars=tab:\|.,extends:»,trail:·
"set listchars=tab:\|.,extends:»,trail:·,nbsp:.

set history=1000 " remember more commands and search history
set undolevels=1000 " use many muchos levels of undo

au FocusLost * :wa	"save on losing focus

" Plugin
" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
"->call pathogen#helptags()
"->call pathogen#runtime_append_all_bundles()

nnoremap <silent> <F9> :YRShow<cr>
inoremap <silent> <F9> <ESC>:YRShow<cr>

filetype plugin indent on

:au Filetype html,xml,xsl source $VIM/vimfile/plugin/closetag.vim