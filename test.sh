#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# # Removing Chromes's apps
# systemsetup -setremotelogin on
# dseditgroup -o create -q com.apple.access_ssh
# dseditgroup -o edit -a admin -t group com.apple.access_ssh

apm install --packages-file Apps/apm.txt

# Installing brackets packeges
extensions=($(cat ./Apps/brackets.txt))
length=${#extensions[@]}
for (( i=0; i<${length}; i++ ));
do
  IFS='/' read -a record <<< "${extensions[$i]}"
  git clone https://github.com/${record[0]}/${record[1]}.git ~/Library/Application\ Support/Brackets/extensions/user/${record[1]}
done
cd ~/Library/Application\ Support/Brackets/extensions/user/brackets-jscs/
npm install
cd $DOTFILES_DIR

IFS=$'\n'
sourceDotfile=($(cat ./DF/source.txt))
destination=($(cat ./DF/destination.txt))

# Putting the files in the correct position.
length=${#sourceDotfile[@]}
for (( i=0; i<${length}; i++ ));
do
  ln -svfn $DOTFILES_DIR/${sourceDotfile[$i]} "`eval echo ${destination[$i]//>}`"
done

