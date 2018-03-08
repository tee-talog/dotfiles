#!/bin/bash

function f_install_zsh() {
    # is zsh installed?
    type zsh >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    fi

    # install zsh
    sudo yum -y install zsh

    # change shell
    type chsh >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        chsh -s /bin/zsh
    else
        echo "Please change shell"
    fi

    return 0
}

