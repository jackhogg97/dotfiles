#!/bin/bash

if ! which stow > /dev/null; then
 echo "Please install stow"
 exit 1
fi

stow zsh
stow tmux
stow nvim
stow git

echo "In Tmux, run '<prefix> I' reload with '<prefix> R'"

exec zsh
