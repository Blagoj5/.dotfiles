#!/bin/bash

# Moving logic
# Moving tmux

echo "Moving zsh to root"
if [ -f ~/.zshrc ]; then 
  echo "Moving old .zshrc to .zshrc.backup"
  mv ~/.zshrc ~/.zshrc.backup
fi
cp ./.zshrc ~/.zshrc
if [ -f ~/.zsh_profile ]; then 
  echo "Moving old .zsh_profile to .zsh_profile.backup"
  mv ~/.zsh_profile ~/.zsh_profile.backup
fi
cp ./.zsh_profile ~/.zsh_profile 

echo "Moving tmux conf to root (~)"
if [ -f ~/.tmux.conf ]; then 
  echo "Moving old .tmux.conf to .tmux.conf.backup"
  mv ~/.tmux.conf ~/.tmux.conf.backup
fi
cp ./.tmux.conf ~/.tmux.conf

echo "Moving i3 conf to ~/.config/i3 and ~/.config/i3status"
if [ -d ~/.config/i3 ]; then 
  echo "Moving old i3 to i3.backup"
  mv ~/.config/i3 ~/.config/i3.backup
fi
cp -r ./.config/i3 ~/.config/i3
if [ -d ~/.config/i3status ]; then 
  echo "Moving old i3status to i3status.backup"
  mv ~/.config/i3status ~/.config/i3status.backup
fi
cp -r ./.config/i3status ~/.config/i3status

echo "Moving personal to ~/.config/personal"
if [ -d ~/.config/personal ]
then 
  cp -r ./.config/personal/* ~/.config/personal/*
else 
  cp -r ./.config/personal ~/.config/personal
fi

echo "Moving alacritty to ~/.config/alacritty"
if [ -d ~/.config/alacritty ]; then 
  echo "Moving old alacritty to alacritty.backup"
  mv ~/.config/alacritty ~/.config/alacritty.backup
fi
cp -r ./.config/alacritty ~/.config/alacritty

echo "Moving fonts to ~/.local/share/fonts"
if [ ! -d ~/.local/share/fonts ]; then 
  mkdir -p ~/.local/share/fonts
fi
cp -r ./.local/share/fonts/* ~/.local/share/fonts/

echo "Moving bin to ~/.local/bin"
if [ ! -d ~/.local/bin ]; then 
  mkdir -p ~/.local/bin
fi
cp -r ./.local/bin/* ~/.local/bin/

echo "Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
source ~/.zshrc