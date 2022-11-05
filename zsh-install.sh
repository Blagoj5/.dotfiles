zsh=`command -v zsh`
if [ -z "$zsh" ]; then
  sudo apt install zsh
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Moving zsh to root"
if [ -f ~/.zshrc ]; then 
  if [ "$REPLY" = "n" ]; then
    echo "Existing installation"
    exit 1
  elif [ "$REPLY" = "y" ]; then
    rm ~/.zshrc
  fi
fi
cp ./.zshrc ~/.zshrc

if [ -f ~/.zsh_profile ]; then 
  echo "Moving old .zsh_profile to .zsh_profile.backup"
  mv ~/.zsh_profile ~/.zsh_profile.backup
fi
cp ./.zsh_profile ~/.zsh_profile 

echo "ZSH Installed"