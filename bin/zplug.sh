#!/bin/bash

function f_install_zplug() {
  # is zplug installed?
  type zplug &>/dev/null
  if [ $? -eq 0 ]; then
    return 0
  fi

  # install zplug
  curl -sL --proto-redir -all,https \
      https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

