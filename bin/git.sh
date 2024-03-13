#!/bin/bash

function f_install_git() {
  # is Git installed?
  type git &>/dev/null
  if [ $? -eq 0 ]; then
    return 0
  fi

  # install Git
  type yum &>/dev/null
  if [ $? -eq 0 ]; then
    sudo yum install -y git-all
  else
    echo "cannot use yum"
    return 1
  fi
}

