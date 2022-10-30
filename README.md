# .dotfiles

## Required
- Neovim v0.8
- I3WM
  - picom (composer)
  - nitrogen (background)
  - blueman (GUI bluetooth manager)
  - pavucontrol (GUI for audio), also available shortcuts for handling sound (pactl) 
  
Good read: https://www.makeuseof.com/things-to-do-after-installing-i3wm/

## Structure

How it should like on your LINUX:
```
~(root)
│   .tmux.conf
│   .zshrc
│   .zsh_profile
└───.config
│   │   nvim
│   │   │   *.lua
│   │   alacritty
│   │   │   *
│   │   i3
│   │   │   config
│   │   i3status
│   │   │   config
│   │   personal
│   │   │   env
│   │   │   path
└───.local
│   │   share
│   │   │   fonts
│   │   │   │   Hack*.tff
```

### NVIM
READ: https://github.com/jdhao/nvim-config
- Make sure you install all the LSP servers in order for it to work
