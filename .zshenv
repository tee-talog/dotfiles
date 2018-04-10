####################
## Key bind
####################
# alias
local TRASH_DIR="~/.Trash"
if [ -e "${TRASH_DIR}" ] && [ -d "${TRASH_DIR}" ]; then
  : "NOP"
else
  if [ type mkdir &>/dev/null ]; then
    mkdir -p "${TRASH_DIR}"
  elif [ type /bin/mkdir &>/dev/null ]; then
    /bin/mkdir -p "${TRASH_DIR}"
  else
    echo "cannot create \`~/.Trash\` dir."
  fi
fi
alias rm="mv --backup=numbered --target-directory=${TRASH_DIR}"

