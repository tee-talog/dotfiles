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
" Plugin
"================================================"

let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' .. substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

let s:dein_base = '~/.cache/dein/'
let s:dein_src = '~/.cache/dein/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' .. s:dein_src

call dein#begin(s:dein_base)
call dein#add(s:dein_src)

"--------------------------------------"
" Install plugins
"--------------------------------------"

"" color: hybrid
call dein#add('w0ng/vim-hybrid')
"" emmet
call dein#add('mattn/emmet-vim')
"" HTML close tag
call dein#add('vim-scripts/closetag.vim')
"" Show indent
call dein#add('Yggdroot/indentLine')
"" Show git status column
call dein#add('airblade/vim-gitgutter')
"" commandline color
call dein#add('itchyny/lightline.vim')
"" repeat macro command
call dein#add('kana/vim-repeat')
"" highlight the active window
"" depends Pynvim
call dein#add('TaDaa/vimade')
"" Increment / Decrement date
call dein#add('tpope/vim-speeddating')
"" EditorConfig
call dein#add('editorconfig/editorconfig-vim')
"" Git conflict highlighter
call dein#add('rhysd/conflict-marker.vim')
"" JSON plugin
call dein#add('elzr/vim-json')
"" easymotion
call dein#add('easymotion/vim-easymotion')
"" improve to move on camelCase
call dein#add('bkad/CamelCaseMotion')

call dein#end()

"" Uncomment if you want to install not-installed plugins on startup.
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

let g:lightline = {
  \   'colorscheme': 'jellybeans',
  \ }
set laststatus=2
set noshowmode

"" disable conceal in JSON file
let g:vim_json_syntax_conceal = 0

"" easymotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1

"" CamelCaseMotion
let g:camelcasemotion_key = '<leader>'


"================================================"
" Color
"================================================"

set t_Co=256

"" hybrid settings
set background=dark
colorscheme hybrid
"" gray background
let g:hybrid_reduced_contrast = 1

"" Define original colors
hi ColorColumn guifg=#000d18 gui=bold
hi MatchParen guibg=#464646 guifg=#efefef gui=bold
hi Search term=reverse ctermfg=230 ctermbg=238 guifg=#ffffe0 guibg=#4f4f4f gui=bold


"================================================"
" Environment settings
"================================================"

"" can use the mouse
if has('mouse')
  set mouse=a
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
"" realtime replace
set inccommand=split

"--------------------------------------"
"" Input
"--------------------------------------"
set autoindent
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
" Clipboard
"--------------------------------------"
"" WSL2
if system('uname -a | grep Microsoft') != ""
  let g:clipboard = {
        \   'name': 'myClipboard',
        \   'copy': {
        \      '+': 'win32yank.exe -i',
        \      '*': 'win32yank.exe -i',
        \    },
        \   'paste': {
        \      '+': 'win32yank.exe -o',
        \      '*': 'win32yank.exe -o',
        \   },
        \   'cache_enabled': 1,
        \ }
endif
"" share OS
set clipboard+=unnamed

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

""" leader key
let mapleader = "\<space>"

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

"" transition to normal mode
inoremap <silent> jj <ESC>
inoremap <C-i> <ESC>

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

"" easymotion
map <Leader><Leader> <Plug>(easymotion-prefix)

