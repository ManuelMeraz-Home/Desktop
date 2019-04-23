#! /usr/bin/env bash

# Shows a spinner while running  a command
spinner() {
  $@ &> /dev/null &
  PID=$!
  i=1
  sp="/-\|"
  #echo -n ' '
  while [ -d /proc/$PID ]
  do
    printf "\b${sp:i++%${#sp}:1}"
  done
  printf "\b"
}

applications=("vim" "tmux" "silversearcher-ag" "git" "htop" 
              "tree" "openssh-server" "openssh-client" "tansmission"
              "geany" "bash-completion" "cmake")

echo "Installing favorite applications..."
spinner sudo apt -qq update 

for app in ${applications[@]}; do
  echo "$app"
  spinner sudo apt -qq install $app -y
done

echo "spotify"
spinner snap install spotify

echo "Setup git submodules (.vim, projects/ etc)..."
git submodule update --init --recursive > /dev/null
spinner $HOME/.vim/setup.sh

echo "Done!"
