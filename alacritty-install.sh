echo "Moving fonts to ~/.local/share/fonts"
if [ ! -d ~/.local/share/fonts ]; then 
  mkdir -p ~/.local/share/fonts
fi
cp -r ./.local/share/fonts/* ~/.local/share/fonts/

alacritty=`command -v alacritty`
if [ -z "$alacritty" ]; then
  sudo add-apt-repository ppa:aslatter/ppa
  sudo apt update
  sudo apt install alacritty
fi

echo "Moving alacritty to ~/.config/alacritty"
if [ -d ~/.config/alacritty ]; then 
  echo "Moving old alacritty to alacritty.backup"
  mv ~/.config/alacritty ~/.config/alacritty.backup
else
  mkdir ~/.config/alacritty 
fi
cp -r ./.config/alacritty/* ~/.config/alacritty

echo "Alacritty  Installed"