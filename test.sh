#!/usr/bin/bash
vim -Nu <(cat << VIMRC
filetype off
set rtp+=third_party/vader.vim
set rtp+=.
set rtp+=after
filetype plugin indent on
syntax enable
VIMRC
) -c 'Vader! test/*' > /dev/null && echo -e "\e[;32mSuccess\e[;m" || echo -e "\e[;31mFailure\e[;m"
