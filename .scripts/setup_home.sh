#! /usr/bin/env bash

echo "Installing favorite applications..."
spinner sudo apt -qq update 
spinner sudo apt -qq install vim tmux silversearcher-ag git htop tree openssh-server transmission geany bash-completion -y
spinner snap install spotify > /dev/null

echo "Setup git submodules (.vim, projects/ etc)..."
spinner git submodule update --init --recursive > /dev/null
spinner $HOME/.vim/setup.sh

echo "Done!"
