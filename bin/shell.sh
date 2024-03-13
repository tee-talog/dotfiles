#!/bin/bash

function f_install_zsh() {
  # is zsh installed?
  type zsh &>/dev/null
  if [ $? -eq 0 ]; then
    return 0
  fi

  # install zsh
  type yum &>/dev/null
  if [ $? -eq 0 ]; then
    sudo yum -y install zsh
  else
    echo "cannot use yum"
    return 1
  fi

  # change shell
  type chsh &>/dev/null
  if [ $? -eq 0 ]; then
    chsh -s /bin/zsh
  else
    echo "Please change shell yourself"
  fi

  return 0
}

