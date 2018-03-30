####################
## Key bind
####################
# alias
local TRASH_DIR="~/.Trash"
mkdir -p "${TRASH_DIR}"
alias rm="mv --backup=numbered --target-directory=${TRASH_DIR}"

