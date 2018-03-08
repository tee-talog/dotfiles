####################
## Key bind
####################
# alias
shopt -s expand_aliases
local TRASH_DIR="~/.Trash"
mkdir -p "${TRASH_DIR}"
alias rm="mv --backup=numbered --target-directory=${TRASH_DIR}"

####################
## PATH
####################
# set your path
export PATH

