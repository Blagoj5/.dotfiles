# .dotfiles

## Required

- Neovim v0.8
- I3WM
  - picom (composer) (Ubuntu 22 and later has it)
  - nitrogen (background)
  - blueman (GUI bluetooth manager)
  - pavucontrol (GUI for audio)
  - pactl (CLI for sound; it's shipped out of the box with ubuntu distro)

[Good read for general i3 setup](https://www.makeuseof.com/things-to-do-after-installing-i3wm/)
[Setting up touchpad and natural scrolling (laptop stuff)](https://cravencode.com/post/essentials/enable-tap-to-click-in-i3wm/)

## Structure

How it should like on your LINUX:
```
~(root)
│   .tmux.conf
│   .zshrc
│   .zsh_profile
│   .Xmodmap
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
│   │   qutebrowser
│   │   │   config.py
└───.local
│   │   share
│   │   │   fonts
│   │   │   │   Hack*.tff
```

### NVIM
READ: https://github.com/jdhao/nvim-config
- Make sure you install all the LSP servers in order for it to work
