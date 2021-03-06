#! /bin/bash bash

if [[ -e $HOME/.home_setup ]]; then
  echo "Home is already setup!" || return 1
  return 1
fi

desktop_branch="master"
vim_branch="maximal"

request_reboot() { echo 'Reboot? Need to restart to complete Installation. (y/n)' && read x && [[ "$x" == "y" ]] && /sbin/reboot; }
request_install_displaylink_drivers() { echo 'Install displaylink drivers?. (y/n)' && read x && [[ "$x" == "y" ]] && sudo $HOME/.scripts/displaylink_driver.sh; }

applications=("vim" "tmux" "silversearcher-ag" "git" "htop" 
              "tree" "openssh-server" "openssh-client" 
              "geany" "bash-completion" "cmake" "gcc" "g++"
              "python3-dev" "python-dev" "python3-pip" 
              "build-essential" "clang" "clang-tidy" "clang-format" 
              "clang-tools" "gdb" "xcape" "wget" "docker.io")


echo "Sudo is required. Password might be prompted"
sudo sleep 1 || (echo "Exiting script, was not succesful" && return 1)

echo "Making docker group and adding $(whoami) to the group"
sudo addgroup docker || (echo "Docker group already exists, not making")
sudo usermod -aG docker $(whoami) || (echo "Attempted to make the user $(whoami) a part of the docker group, but failed." && return 1)

echo "Updating, upgrading, and Installing favorite applications..."
sudo apt -qq update && sudo apt -qq upgrade -y && sudo apt -qq install -y ${applications[*]} || (echo "Failed to run updates" && return 1)

echo "Setting up git home repository"
if [ ! -d $HOME/.ssh ]; then
    mkdir $HOME/.ssh || (echo "Failed to make ~/.ssh directory" && return 1)
fi

if [ ! -e $HOME/.ssh/config ]; then
    wget https://gist.githubusercontent.com/ManuelMeraz/d216bdca170766b053a110b97abc6648/raw/d56e5acbb891f0e37f1564bd03d5e12e0a5d4bac/config -P $HOME/.ssh || (echo "Failed ot get ssh config file from github" &&  return 1)
fi

if [ ! -e $HOME/.ssh/known_hosts ]; then
    touch $HOME/.ssh/known_hosts || (echo "Failed to make known ssh hosts" && return 1)
fi
   
if [ -e $HOME/.profile ]; then
    rm $HOME/.profile || return 1
fi

if [ -e $HOME/.bashrc ]; then
    rm $HOME/.bashrc || return 1
fi

(ssh-keygen -F github.com || ssh-keyscan github.com >> $HOME/.ssh/known_hosts) || return 1
git init && git remote add origin https://github.com/manuelmeraz/home.git || return 1

git pull origin master  || return 1
git update-index --assume-unchanged $HOME/.profile || return 1

source ~/.bashrc  || return 1

echo "Setting up .vim and projects submodules..."
git submodule update --init --recursive || return 1
$HOME/.vim/setup.sh || (echo "Attempted to run vim setup script and failed" && return 1)

touch $HOME/.home_setup 
source ~/.profile || return 1

(rm -rf $HOME/.git && rm $HOME/README.md && rm $HOME/LICENSE && rm $HOME/projects/README.md)  &> /dev/null || true

request_install_displaylink_drivers  || return 1
request_reboot  || return 1
echo "Done!"

