#!/bin/bash

docker run -v $HOME/.dotfiles/setup:/temp/ansiblee -it test /bin/bash
