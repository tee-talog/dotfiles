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
# specify format
HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S '
# line in the middle of the comment
setopt interactivecomments
# not add duplicate continuity command to histfile
setopt hist_ignore_dups

####################
## Completion
####################
# specify completion functions
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
# add color at the time of completion
zstyle ':completion:*' list-colors ''
# scroll completion prompt
# show only
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# selectable
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# can select arrow keys
zstyle ':completion:*' menu select=2
# extend display
zstyle ':completion:*' verbose true
# after "../", not complete current directory
zstyle ':completion:*' ignore-parents parent pwd ..


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
# no remove trailing slash of command line
setopt noautoremoveslash
# compacked complete list display
setopt list_packed

# use PCRE
setopt re_match_pcre

# no beep sound when complete list displayed
setopt nolistbeep
# command correct edition before each completion attempt
setopt correct

####################
## Key bind
####################
bindkey -e

# alias
alias la='ls -alh --color=auto'
alias df='df -h'
alias du='du -h'
alias psa='ps -auxf'
alias psah='ps -auxf | grep ${HOME}'
alias sjis='(){ $* |& iconv -f cp932 -t utf-8 }'
alias less='less -MNR'
alias crontab='crontab -i'

function f_killall() {
  ps -W | grep "$1" | awk '{print $1}' | while read -r line; do echo "${line}" | xargs kill -f; done
}
alias killall='f_killall'

function f_sjis_to_utf8() {
  $* |& iconv -f cp932 -t utf-8
}
alias sjis='f_sjis_to_utf8'

# turn off <C-?> shortcut
stty stop undef
stty swtch undef
stty susp undef

####################
## Character
####################
export LANG=ja_JP.UTF-8
export LC_ALL=C.UTF-8

# change word delimiter
autoload -Uz select-word-style
select-word-style default
# delimiter charcters
zstyle ':zle:*' word-chars " /=;@:{}.,|"
zstyle ':zle:*' word-style unspecified

# show multibyte file name
setopt print_eight_bit

####################
## Other
####################
# auto change directory
setopt auto_cd
# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd

# no beep sound
setopt no_beep

