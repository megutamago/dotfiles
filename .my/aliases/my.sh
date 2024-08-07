#!/bin/bash

# git
# shellcheck disable=SC2139
# alias branchclean="git fetch --prune && git branch -v | grep \\[gone] | awk '{print $1}' | xargs git branch -d"
alias gitpush='git add -A && git commit -m "submit" && git push origin main'

# clear
alias clr='rm ~/.ssh/known_hosts'
alias mclear='sudo echo 3 > /proc/sys/vm/drop_caches'

# keygen
alias keygen='ssh-keygen -t ed25519 -C "" -f ./keygen -N ""'

# ssh
alias basessh='ssh root@192.168.11.11'

# grep
alias grepclean="grep -v -e '^\s*#' -e '^\s*$'" # grepclean [file]

# cheat
alias cheat='vim ~/.my/cheatsheet.sh'
alias cheatvim='vim ~/.my/cheatsheet_vim.sh'

# tmux
# alias kill='tmux kill-session'
# if [[ ! "$TERM" =~ "screen" ]]; then
#   tmux -2 attach || tmux -2 new-session \; source-file ~/.tmux/new-session
# fi
