#!/bin/bash

function f_create_dotfile_links() {
    ls -1 |
        grep -E '\..*' |
        xargs -i ln -snf dotfile/{} ~/{}
}

