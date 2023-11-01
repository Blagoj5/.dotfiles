#!/bin/bash

stow -D nvim
stow --verbose=2 nvim
stow -D alacitty
stow --verbose=2 alacritty
stow -D personal
stow --verbose=2 personal
stow -D local
stow --verbose=2 local
stow -D i3
stow --verbose=2 i3
stow -D tmux
stow --verbose=2 tmux
rm ../.zshrc
stow -D zsh
stow --verbose=2 zsh
stow -D applescript
stow --verbose=2 applescript
stow -D skhd
stow --verbose=2 skhd
stow -D .hammerspoon
stow --verbose=2 .hammerspoon
