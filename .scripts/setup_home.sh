#! /usr/bin/env bash

if [[ -e $HOME/.home_setup ]]; then
  echo "Home is already setup!"
  exit 0
fi
  

# Shows a spinner while running  a command
spinner() {
  $@ &> /dev/null &
  PID=$!
  i=1
  sp="/-\|"
  echo -n ' '
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
(spinner sudo apt -qq update)

for app in ${applications[@]}; do
  echo "$app"
  (spinner sudo apt -qq install $app -y)
done

echo "spotify"
(spinner snap install spotify)

echo "Setting up git home repository"
(spinner git init && git remote add origin https://github.com/manuelmeraz/home.git)
if [[ -z $? ]]; then
  (spinner rm $HOME/.bash_logout $HOME/.bashrc $HOME/.profile)
fi
(spinner git pull origin master)
(spinner source ~/.profile)

echo "Setup git submodules (.vim, projects/ etc)..."
git submodule update --init --recursive > /dev/null
echo "Setup .vim..."
(spinner $HOME/.vim/setup.sh)

touch $HOME/.home_setup
source $HOME/.profile

echo "Done!"
