echo "Installing Nvim"
nvim=`command -v nvim`
if [ -z "$nvim" ]; then
  curl -o ./nvim-linux64.deb -JLO https://github.com/neovim/neovim/releases/download/v0.8.1/nvim-linux64.deb
  sudo apt install ./nvim-linux64.deb
  rm ./nvim-linux64.deb
fi


echo "Installing Packer"
packer=`command -v packer`
if [ -z "$packer" ]; then 
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt-get update && sudo apt-get install packer
fi

echo "Installing Rigrep"
packer=`command -v rigrep`
if [ -z "$packer" ]; then 
  sudo apt-get install ripgrep
fi

echo "Installing Clang-12"
clang=`command -v clang-12`
if [ -z "$clang" ]; then 
  sudo apt install clang-12 --install-suggests
fi

echo "Installing LSP servers"
npm install -g typescript typescript-language-server eslint_d cspell tree-sitter-cli


# TODO: adress this
luaServer=`command -v lua-language-server`
if [ -z "$luaServer" ]; then 
  ninja=`command -v ninja`
  if [ -z "$ninja" ]; then 
    sudo wget -qO /usr/local/bin/ninja.gz https://github.com/ninja-build/ninja/releases/latest/download/ninja-linux.zip
    sudo gunzip /usr/local/bin/ninja.gz
    sudo chmod a+x /usr/local/bin/ninja
  fi
  mkdir -p ~/.config/lsp
  cd ~/.config/lsp
  git clone --depth=1 https://github.com/sumneko/lua-language-server
  cd lua-language-server
  git submodule update --depth 1 --init --recursive
  cd 3rd/luamake
  ./compile/install.sh
  cd ../..
  ./3rd/luamake/luamake rebuild
  echo 'export PATH="${HOME}/.config/lsp/lua-language-server/bin:${PATH}"' >> ~/.bashrc
  echo 'export PATH="${HOME}/.config/lsp/lua-language-server/bin:${PATH}"' >> ~/.zsh_profile
  source ~/.bashrc
  source ~/.zshrc
fi

echo "Moving nvim to root"
if [ -d "$HOME/.config/nvim" ]; then 
  echo -n "~/.config/nvim already exists, overwrite? (y/n)"
  read CONFIRM
  if [ "$CONFIRM" = "y" ]; then
    echo "Moved new nvim config"
    rm -r ~/.config/nvim
    mkdir ~/.config/nvim
    cp -r ./.config/nvim/* ~/.config/nvim/
    exit 1
  elif [ "$CONFIRM" = "n" ]; then
    echo "Exiting installation"
  fi
else 
  mkdir -p ~/.config/nvim
  cp -r ./.config/nvim/* ~/.config/nvim/
fi

echo "Moving fonts to ~/.local/share/fonts"
if [ ! -d ~/.local/share/fonts ]; then 
  mkdir -p ~/.local/share/fonts
fi
cp -r ./.local/share/fonts/* ~/.local/share/fonts/
