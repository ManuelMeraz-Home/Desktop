#! /usr/bin/env bash

echo "Installing favorite applications..."
(apt -qq update) &> /dev/null
(apt -qq install vim tmux silversearcher-ag git htop tree openssh-server transmission geany bash-completion -y) &> /dev/null
(snap install spotify) > /dev/null

echo "Setup git submodules (.vim, projects/ etc)..."
(git submodule update --init --recursive) > /dev/null

echo "Done!"
