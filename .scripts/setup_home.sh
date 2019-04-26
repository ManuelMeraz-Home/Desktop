#! /usr/bin/env bash

if [[ -e $HOME/.home_setup ]]; then
  echo "Home is already setup!"
  return 1
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
              "geany" "bash-completion" "cmake" "gcc" "g++" "python3"
              "python3-dev" "python-dev" "python3-pip" "python-pip"
              "build-essential" "clang" "clang-tidy" "clang-format")


echo "Sudo is required. Password might be prompted"
sudo sleep 1

if [[ $? != 0 ]]; then
  echo "Exiting script, was not succesful"
  return 1
fi

echo "Installing favorite applications..."
(spinner sudo apt -qq update)

echo "Installing favorite applications..."
for app in ${applications[@]}; do
  echo "$app"
  (spinner sudo apt -qq install $app -y)
done

echo "spotify"
(spinner snap install spotify)

echo "Setting up git home repository"
(spinner git init && git remote add origin https://github.com/manuelmeraz/home.git)
(spinner rm $HOME/.bash_logout $HOME/.bashrc $HOME/.profile)
(spinner git pull origin master)
(spinner git update-index --assume-unchanged $HOME/.profile)

echo "Setting up .vim and projects submodules..."
(spinner git submodule update --init --recursive --remote)
(spinner $HOME/.vim/setup.sh)

(spinner touch $HOME/.home_setup)
source ~/.profile

echo "Done!"
