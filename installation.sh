#!/bin/bash

# sudo apt update

i3=`command -v i3`
if [ -z "$i3" ]; then
  sudo apt install i3
fi

zsh=`command -v zsh`
if [ -z "$zsh" ]; then
  sudo apt install zsh
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

alacritty=`command -v alacritty`
if [ -z "$alacritty" ]; then
  sudo add-apt-repository ppa:aslatter/ppa
  sudo apt update
  sudo apt install alacritty
fi

tmux=`command -v tmux`
if [ -z "$tmux" ]; then
  sudo apt-get update
  sudo apt-get install tmux
fi

curl=`command -v curl`
if [ -z "$curl" ]; then
  sudo apt install curl
fi

nvim=`command -v nvim`
if [ -z "$nvim" ]; then
  curl -o ./nvim-linux64.deb -JLO https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.deb
  sudo apt install ./nvim-linux64.deb
  rm ./nvim-linux64.deb
fi

nvim=`command -v nvim`
if [ -z "$nvim" ]; then
  curl -o ./nvim-linux64.deb -JLO https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.deb
  sudo apt install ./nvim-linux64.deb
  rm ./nvim-linux64.deb
fi

fzf=`command -v nvim`
if [ -z "$fzf" ]; then
  echo "Installing fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  source ~/.zshrc
fi

echo COMPLETE

