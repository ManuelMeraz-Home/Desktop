#! /usr/bin/env bash

applications=("vim" "tmux" "silversearcher-ag" "git" "htop" 
              "tree" "openssh-server" "openssh-client" "tansmission"
              "geany" "bash-completion")

echo "Installing favorite applications..."
spinner sudo apt -qq update &> /dev/null

for app in ${applications[@]}; do
  echo "$app"
  sudo apt -qq install $app -y &> /dev/null
done

echo "spotify"
snap install spotify &> /dev/null

echo "Setup git submodules (.vim, projects/ etc)..."
git submodule update --init --recursive > /dev/null
spinner $HOME/.vim/setup.sh

echo "Done!"
