if &compatible
  set nocompatible
endif

augroup vimrc
  autocmd!
augroup END


"================================================"
" Character Encoding
"================================================"

scriptencoding UTF-8
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8


"================================================"
" Color
"================================================"

set t_Co=256
source ~/.vim/colors/zenburn.vim
colorscheme zenburn

"" Define original colors
hi ColorColumn guifg=#000d18 gui=bold
hi MatchParen guibg=#464646 guifg=#efefef gui=bold
hi Search term=reverse ctermfg=230 ctermbg=238 guifg=#ffffe0 guibg=#4f4f4f gui=bold


"================================================"
" Plugin
"================================================"

""" dein.vim
"" base installation dir
let s:plugin_dir = '~/.vim/plugins'
"" dein.vim installation dir
let s:dein_repo_dir = s:plugin_dir . '/dein.vim'

"" if the dein.vim is not exists then it download and install
if &runtimepath !~# '/dein.vim'
  if !isdirectory(expand(s:dein_repo_dir))
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath+=' . expand(s:dein_repo_dir)
endif

"--------------------------------------"
" Install plugins
"--------------------------------------"

call dein#begin(s:plugin_dir)
call dein#add('Shougo/dein.vim')

"" TODO TOML

"" set file types
autocmd vimrc BufRead,BufNewFile *.js  setfiletype javascript
autocmd vimrc BufRead,BufNewFile *.es6 setfiletype javascript
autocmd vimrc BufRead,BufNewFile *.jsx setfiletype javascript.jsx
autocmd vimrc BufRead,BufNewFile *.vue setfiletype vue

"" emmet
call dein#add('mattn/emmet-vim')
"" TypeScript syntax highlight
call dein#add('leafgarland/typescript-vim')
"" EditorConfig
call dein#add('editorconfig/editorconfig-vim')
"" Vue Hilight
call dein#add('posva/vim-vue')
"" Show indent
call dein#add('Yggdroot/indentLine')

"" End installation
call dein#end()

"" if plugins that is not installed exists then install it
if dein#check_install()
  call dein#install()
endif

"--------------------------------------"
" Plugins configuration
"--------------------------------------"

"" emmet
let g:user_emmet_settings = {
\   'variables': {
\     'lang': "ja"
\   },
\ }

"" vue highlight
autocmd vimrc FileType vue syntax sync fromstart


"================================================"
" Environment settings
"================================================"

"" to be able to use the mouse
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

"" to correction the indentation when you paste
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif


"================================================"
" Vim common settings
"================================================"

"--------------------------------------"
" Backup
"--------------------------------------"
set backupdir=~/.vim/backups
"" set default save dir to buffer file dir
set browsedir=buffer
"" set swap file dir
set directory=~/.vim/swaps
"" max of saving history
set history=10000
"" set undo dir
if has('persistent_undo')
  set undodir=~/.vim/undos
  set undofile
endif

"--------------------------------------"
" Search
"--------------------------------------"
"" enable increment search
set incsearch
"" highlight search result
set hlsearch
set ignorecase
"" if search word containts uppercase then it is case-sensitive seach
set smartcase
"" loop
set wrapscan

"" the cursor doesn't move when versus parenthesis match
set matchtime=0

"--------------------------------------"
"" Input
"--------------------------------------"
set autoindent
set smartindent
"" tab ize
set shiftwidth=4
set tabstop=4
"" not stop cursor at line-begin and line-end
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
"" the line is not indent when you paste
set nopaste
"" comment is not continue when you start a new line in comment
autocmd FileType * setlocal formatoptions-=ro

"--------------------------------------"
" Completion
"--------------------------------------"

"" complete in command mode
set wildmenu
"" command line shows shortest completion once when you complete in command line
set wildmode=longest:full,full

"--------------------------------------"
" whitespace
"--------------------------------------"
"" show tab and crlf
set list
set listchars=tab:>-,trail:-,eol:$
"" 2bite-space to red
augroup highlightZenkakuSpace
  autocmd!
  autocmd VimEnter,ColorScheme * highlight ZenkakuSpace term=underline ctermbg=Red guibg=Red
  autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
augroup END

"--------------------------------------"
" Display
"--------------------------------------"

"" show cursor place
set cursorline
set cursorcolumn
"" show ruler
set ruler

"" show command
set showcmd

"" show line number
set number
"" show properly 2bite-charactors
set ambiwidth=double
"" enable syntax highlight
syntax on

"--------------------------------------"
" Others
"--------------------------------------"
"" extends `%`
source $VIMRUNTIME/macros/matchit.vim
"" line wraps at right edge of window
set wrap


"================================================"
" Key mappping
"================================================"

"" the commands that move cursor when vim mode is insert mode
"" foward
inoremap <c-f> <right>
"" backward
inoremap <c-b> <left>
"" to beggining of line
inoremap <c-a> <c-o>0
"" to end of line
inoremap <c-e> <c-o>$

"" visual mode is not release when you indent with `<` and `>` in visual mode
vnoremap < <gv
vnoremap > >gv

"" if line wrapped then cursor moves line as they appear with `j` and `k`
"" conversely, when I want to move logically-line, I can use `gj` and `gk`
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

"" vim displays cadidate at center of screen
"" when you search and show next and previous candidate
nnoremap n nzz
nnoremap N Nzz

"" yank from cursor to line-end
nnoremap Y y$

"" transition to normal mode when you input `jj`
inoremap <silent> jj <ESC>

"" no highlight
nnoremap <ESC><ESC> :nohlsearch<CR>

"" don't yank by `x` and `s`
nnoremap x "_x
nnoremap X "_X
nnoremap s "_s
nnoremap S "_S

"" open new tab
nnoremap <C-w>t :<C-u>tabnew<CR>

"" scroll on a line-by-line
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

