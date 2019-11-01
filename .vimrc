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
"" HTML close tag
call dein#add('vim-scripts/closetag.vim')
"" TypeScript syntax highlight
call dein#add('leafgarland/typescript-vim')
"" EditorConfig
call dein#add('editorconfig/editorconfig-vim')
"" Vue Highlight
call dein#add('posva/vim-vue')
"" Show indent
call dein#add('Yggdroot/indentLine')
"" Show replacing preview
call dein#add('osyo-manga/vim-over')
"" Show git status column
call dein#add('airblade/vim-gitgutter')
"" commandline color
call dein#add('itchyny/lightline.vim')
"" JSON plugin
call dein#add('elzr/vim-json')
"" Syntax highlighting for Stylus
call dein#add('wavded/vim-stylus')
"" Syntax highlighting for Pug (Jade)
call dein#add('digitaltoad/vim-pug')
"" completion
if !has('nvim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif
"" Git conflict highlighter
call dein#add('rhysd/conflict-marker.vim')
"" prettier
call dein#add('prettier/vim-prettier', { 'build': 'npm install' })

"" color: hybrid
call dein#add('w0ng/vim-hybrid')

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

"" replacing preview replace
nnoremap <silent> <Space>o :OverCommandLine<CR>%s//g<Left><Left>

let g:lightline = {
  \   'colorscheme': 'jellybeans',
  \ }
set laststatus=2
set noshowmode

"" disable conceal in JSON file
let g:vim_json_syntax_conceal = 0

"" deoplete
let g:deoplete#enable_at_startup = 1
" no check
let g:max_list=16

"" prettier
" plugin settings
let g:prettier#autoformat = 0
" prettier config
let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'babylon'
let g:prettier#config#config_precedence = 'cli-override'
let g:prettier#config#prose_wrap = 'preserve'


"================================================"
" Color
"================================================"

set t_Co=256

"" hybrid settings
set background=dark
colorscheme hybrid
"" gray background
let g:hybrid_reduced_contrast = 1

"" zenburn settings
" TODO source colorscheme file -> plugin system
"source ~/.vim/colors/zenburn.vim
"colorscheme zenburn
"" Define original colors
"hi ColorColumn guifg=#000d18 gui=bold
"hi MatchParen guibg=#464646 guifg=#efefef gui=bold
"hi Search term=reverse ctermfg=230 ctermbg=238 guifg=#ffffe0 guibg=#4f4f4f gui=bold


"================================================"
" Environment settings
"================================================"

"" to be able to use the mouse
if has('mouse')
  set mouse=a
  if !has('nvim')
    if has('mouse_sgr')
      set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
      set ttymouse=sgr
    else
      set ttymouse=xterm2
    endif
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
"" share OS clipboard
set clipboard+=unnamed


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

"" transition to normal mode
inoremap <silent> jj <ESC>
inoremap <C-j> <ESC>

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

