#! /usr/bin/env bash

if [[ -e $HOME/.home_setup ]]; then
  echo "Home is already setup!"
  return 1
fi

applications=("vim" "tmux" "silversearcher-ag" "git" "htop" 
              "tree" "openssh-server" "openssh-client" 
              "geany" "bash-completion" "cmake" "gcc" "g++"
              "python3-dev" "python-dev" "python3-pip" "python-pip"
              "build-essential" "clang" "clang-tidy" "clang-format" 
              "clang-tools" "gdb" "xcape" "wget")


echo "Sudo is required. Password might be prompted"
sudo sleep 1

if [[ $? != 0 ]]; then
  echo "Exiting script, was not succesful"
  return 1
fi

echo "Updating, upgrading, and Installing favorite applications..."
sudo apt -qq update && apt -qq upgrade -y && apt -qq install -y ${applications}


echo "Setting up git home repository"
if [ ! -d $HOME/.ssh ]; then
    mkdir $HOME/.ssh
fi

if [ ! -e $HOME/.ssh/config ]; then
    wget https://gist.githubusercontent.com/ManuelMeraz/d216bdca170766b053a110b97abc6648/raw/d56e5acbb891f0e37f1564bd03d5e12e0a5d4bac/config -P $HOME/.ssh
fi

if [ ! -e $HOME/.ssh/known_hosts ]; then
    touch $HOME/.ssh/known_hosts
fi
   
(ssh-keygen -F github.com || ssh-keyscan github.com >> $HOME/.ssh/known_hosts)
git init && git remote add origin https://github.com/manuelmeraz/home.git

if [ -e $HOME/.profile ]; then
    rm $HOME/.profile
fi

if [ -e $HOME/.bashrc ]; then
    rm $HOME/.bashrc
fi

git pull origin master
git update-index --assume-unchanged $HOME/.profile

source ~/.bashrc

echo "Setting up .vim and projects submodules..."
git submodule update --init --recursive --remote
$HOME/.vim/setup.sh

touch $HOME/.home_setup
source ~/.profile

echo "Done!"
