#!/bin/bash

function f_create_dotfile_links() {
  ls -1 |
    grep -E '\..*' |
    grep -E '\.zshenv' |
    xargs -i ln -snf dotfile/{} ~/{}
}

