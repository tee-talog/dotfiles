#!/bin/bash

local readonly _append_str="
if [ -f \"${HOME}/dotfiles/.zshenv\" ]; then
  source \"${HOME}/dotfiles/.zshenv\"
fi
"

function f_load_zshenv() {
  if [ -e ~/.zshenv ]; then
    cp ~/.zshenv{,_org}
  fi
  echo "${_append_str}" >>~/.zshenv
}

