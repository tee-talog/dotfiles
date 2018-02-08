####################
## Color
####################
# activate color
autoload -U colors
colors

# define colors
local GREEN=$'%{\e[1;32m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'

####################
## Prompt
####################
# normal
PROMPT=$BLUE'%# '$DEFAULT
# right
RPROMPT=$GREEN'[%~]'$DEFAULT
setopt transient_rprompt

# continue
PROMPT2="%_%% "
# suggest
SPROMPT="%r is correct? [n,y,a,e]: "

# show job status immediately
setopt notify

####################
## History
####################
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
# append history file
setopt appendhistory

####################
## Completion
####################
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle :compinstall filename '~/.zshrc'

# complete initialize
autoload -Uz compinit
compinit

setopt extendedglob
# append trailling slash at the time of completion
setopt auto_param_slash
setopt mark_dirs

# complete in command-line option
# e.g. ./config --prefix=/compiletion/here
setopt magic_equal_subst

# use PCRE
setopt re_match_pcre

####################
## Key bind
####################
bindkey -e

# alias
alias la='ls -alh --color=auto'
alias df='df -h'
alias psa='ps -auxf'
alias start='cygstart'
alias sjis='(){ $* |& iconv -f cp932 -t utf-8 }'

local TRASH_DIR="~/.Trash"
mkdir -p "${TRASH_DIR}"
alias rm="mv --backup=numbered --target-directory=${TRASH_DIR}"

####################
## Character
####################
export LANG=ja_JP.UTF-8

