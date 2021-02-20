#! /bin/bash bash

if [[ -e $HOME/.home_setup ]]; then
  echo "Home is already setup!"
  return 1
fi

reboot () { echo 'Reboot? Need to restart to complete Installation. (y/n)' && read x && [[ "$x" == "y" ]] && /sbin/reboot; }

applications=("vim" "tmux" "silversearcher-ag" "git" "htop" 
              "tree" "openssh-server" "openssh-client" 
              "geany" "bash-completion" "cmake" "gcc" "g++"
              "python3-dev" "python-dev" "python3-pip" "python-pip"
              "build-essential" "clang" "clang-tidy" "clang-format" 
              "clang-tools" "gdb" "xcape" "wget" "docker.io")


echo "Sudo is required. Password might be prompted"
sudo sleep 1

if [[ $? != 0 ]]; then
  echo "Exiting script, was not succesful"
  return 1
fi

sudo usermod -aG docker $(whoami) || exit 1

echo "Updating, upgrading, and Installing favorite applications..."
sudo apt -qq update && sudo apt -qq upgrade -y && sudo apt -qq install -y ${applications[*]} || exit 1

echo "Setting up git home repository"
if [ ! -d $HOME/.ssh ]; then
    mkdir $HOME/.ssh || exit 1
fi

if [ ! -e $HOME/.ssh/config ]; then
    wget https://gist.githubusercontent.com/ManuelMeraz/d216bdca170766b053a110b97abc6648/raw/d56e5acbb891f0e37f1564bd03d5e12e0a5d4bac/config -P $HOME/.ssh || exit 1
fi

if [ ! -e $HOME/.ssh/known_hosts ]; then
    touch $HOME/.ssh/known_hosts || exit 1
fi
   
if [ -e $HOME/.profile ]; then
    rm $HOME/.profile || exit 1
fi

if [ -e $HOME/.bashrc ]; then
    rm $HOME/.bashrc || exit 1
fi

(ssh-keygen -F github.com || ssh-keyscan github.com >> $HOME/.ssh/known_hosts)
git init && git remote add origin https://github.com/manuelmeraz/home.git || exit 1

git pull origin master
git update-index --assume-unchanged $HOME/.profile || exit 1

source ~/.bashrc || exit 1

echo "Setting up .vim and projects submodules..."
git submodule update --init --recursive --remote || exit 1
$HOME/.vim/setup.sh || exit 1

touch $HOME/.home_setup
source ~/.profile || exit 1

rm -rf $HOME/.git && rm $HOME/README.md && rm $HOME/LICENSE && $HOME/projects/README.md || exit 1

request_reboot 
echo "Done!"

