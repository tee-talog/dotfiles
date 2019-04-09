####################
## Plugins
####################
source ~/.zplug/init.zsh

# environment-specific plugin
if [[ -f ~/.zsh-plugins ]]; then
  source ~/.zsh-plugins
fi

# zsh 256 clor
zplug "chrissicool/zsh-256color"
# emojify
zplug "mrowa44/emojify", as:command
# syntax highlighting
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# Yarn completion
zplug "g-plane/zsh-yarn-autocompletions", hook-build:"./zplug.zsh", defer:2

#------------------#
# Apply
#------------------#
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  zplug install
fi
# source plugins and add commands to $PATH
zplug load --verbose

#------------------#
# Settings
#------------------#
# syntax highlighting color
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
export ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=green'
export ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'

####################
## Color
####################
# activate color
autoload -U colors
colors

# define colors
local ZSH_RED="%F{009}"
local ZSH_BLUE="%F{063}"
local ZSH_GREEN="%F{047}"
local ZSH_GRAY="%F{244}"
local ZSH_WHITE="%F{255}"
local ZSH_YELLOW="%F{191}"

####################
## Prompt
####################
function f_git_current_branch() {
  # if [[ ! -e ".git" ]]; then
  #   return
  # fi

  local _branch_name="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  local readonly _status="$(git status 2>/dev/null)"

  local _branch_status_color=""
  local _branch_suffix=""

  if [[ -n "$(echo "${_status}" | egrep "^nothing to")" ]]; then
    _branch_status_color="${ZSH_GREEN}"
  elif [[ -n "$(echo "${_status}" | egrep "^Changes to be committed")" ]]; then
    _branch_status_color="${ZSH_YELLOW}"
    _branch_suffix="!"
  elif [[ -n "$(echo "${_status}" | egrep "^Untracked files")" ]]; then
    _branch_status_color="${ZSH_RED}"
    _branch_suffix="?"
  elif [[ -n "$(echo "${_status}" | egrep "^Changes not staged for commit")" ]]; then
    _branch_status_color="${ZSH_RED}"
    _branch_suffix="+"
  elif [[ -n "$(echo "${_status}" | egrep "^rebase in progress")" ]]; then
    _branch_status_color="${ZSH_RED}"
    _branch_suffix="!(no branch)"
  else
    _branch_status_color="${ZSH_BLUE}"
  fi

  echo "${_branch_status_color}${_branch_name} ${_branch_suffix}"
}

function f_show_git_status_in_prompt() {
  PROMPT="
$ZSH_GRAY [%D{%Y/%m/%d} %*] $(f_git_current_branch)
$ZSH_BLUE%(!,#,>) $ZSH_WHITE"
}

# normal
PROMPT="
$ZSH_GRAY [%D{%Y/%m/%d} %*]
$ZSH_BLUE%(!,#,>) $ZSH_WHITE"

# normal with git branch
autoload -Uz add-zsh-hook
add-zsh-hook precmd f_show_git_status_in_prompt

# right
RPROMPT=$ZSH_GREEN'[%~]'$ZSH_WHITE
setopt transient_rprompt

# continue
PROMPT2="%_> "
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

# refer to the command history among other zsh process
setopt share_history
# not add the same command to history
setopt hist_ignore_all_dups
# trim space when add to history
setopt hist_reduce_blanks

####################
## Completion
####################
# specify completion functions
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
# add color at the time of completion
zstyle ':completion:*' list-colors ''
# ignore case completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
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
# use cache
zstyle ':completion:*' use-cache yes
# ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


zstyle :compinstall filename '~/.zshrc'

# complete initialize
autoload -Uz compinit
compinit

setopt extendedglob
# append trailling slash at the time of completion
setopt auto_param_slash
setopt mark_dirs

# complete in command-line option
# e.g. ./config --prefix=/completion/here
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
alias less='less -iWMNR'
alias crontab='crontab -i'
alias grep='(){ \grep "$1" --color=auto }'
alias joinline='(){ paste -s -d "$1" - }'
alias splitline='(){ tr "$1" "\n" }'
alias j='git'

function f_killall() {
  ps -W | grep "$1" | awk '{print $1}' | while read -r line; do echo "${line}" | xargs kill -f; done
}
alias killall='f_killall'

# global alias
if [[ -x /usr/local/bin/peco ]]; then
  alias -g B='"$(git branch -a | peco --prompt "Git Branch: " | head -n 1 | sed -e "s/^\*\s*//g" | xargs)"'
fi

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
zstyle ':zle:*' word-chars " /=;@:{}.,|-_"
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
# not add to move history if duplicate directory in move history
setopt pushd_ignore_dups

# set pager
export PAGER=less
# color
# reference: https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)   # Begins blinking
export LESS_TERMCAP_md=$(tput bold; tput setaf 223) # Begins bold
export LESS_TERMCAP_us=$(tput bold; tput setaf 131) # Begins underline
export LESS_TERMCAP_me=$(tput sgr0)                 # Ends bold, blink and underline
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # Begins standout-mode
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)                  # Ends standout-mode

# no beep sound
setopt no_beep

# set default editor
export EDITOR="$(which vim)"

