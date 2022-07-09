#!/bin/bash

cleanDir () {
  unlink $1
  rm -rf $1
  # mkdir -p $1
}

cleanDir ~/.config/nvim
ln -sfn $PWD/.config/nvim ~/.config/nvim

cleanDir ~/.config/i3
ln -sfn $PWD/.config/i3 ~/.config/i3

cleanDir ~/.config/i3status
ln -sfn $PWD/.config/i3status ~/.config/i3status

cleanDir ~/.config/alacritty
ln -sfn $PWD/.config/alacritty ~/.config/alacritty

# just a file
ln -sfn $PWD/.tmux.conf ~/.tmux.conf
ln -sfn $PWD/.zsh_profile ~/.zsh_profile
