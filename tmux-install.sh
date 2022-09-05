echo "Moving bin to ~/.local/bin"
if [ ! -d ~/.local/bin ]; then 
  mkdir -p ~/.local/bin
fi
cp -r ./.local/bin/* ~/.local/bin/

echo "Moving personal to ~/.config/personal"
if [ ! -d ~/.config/personal ]
then 
  mkdir -p ~/.config/personal
fi
cp -r ./.config/personal/* ~/.config/personal/

tmux=`command -v tmux`
if [ -z "$tmux" ]; then
  sudo apt-get update
  sudo apt-get install tmux
fi

echo "Moving tmux conf to root (~)"
if [ -f ~/.tmux.conf ]; then 
  echo "Moving old .tmux.conf to .tmux.conf.backup"
  mv ~/.tmux.conf ~/.tmux.conf.backup
fi
cp ./.tmux.conf ~/.tmux.conf

fzf=`command -v nvim`
if [ -z "$fzf" ]; then
  echo "Installing fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  source ~/.zshrc
fi

echo "TMUX Installed"