#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

## Symlinking dotfiles. ##
# Getting source and destination for each dotfile in DF/.
IFS=$'\n'
sourceDotfile=($(cat ./DF/source.txt))
destination=($(cat ./DF/destination.txt))

# Putting the fils in the correct position.
length=${#sourceDotfile[@]}
for (( i=0; i<${length}; i++ ));
do
  ln -svfn $DOTFILES_DIR/${sourceDotfile[$i]} "`eval echo ${destination[$i]//>}`" 
done
