#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Select the name for this pc
echo -n "Enter the name for this pc: "
read name
scutil --set HostName $name

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install Command Line Tools
xcode-select --install

# Brew setup.
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/versions
brew update

## Installing apps. ##
# Getting the list of apps from the txts in Apps/.
IFS=$'\n'
brewApp=($(cat ./Apps/brewApp.txt))
caskApp=($(cat ./Apps/caskApp.txt))
nodeApp=($(cat ./Apps/nodeApp.txt))

# Installing the apps in the correct order
brew install ${brewApp[@]}
brew cask install ${caskApp[@]}
npm install -g ${nodeApp[@]}

brew cask alfred link
brew cleanup

## Symlinking dotfiles. ##
# Getting source and destination for each dotfile in DF/.
sourceDotfile=($(cat ./DF/source.txt))
destination=($(cat ./DF/destination.txt))

# Putting the fils in the correct position.
length=${#sourceDotfile[@]}
for (( i=0; i<${length}; i++ ));
do
  ln -sv $DOTFILES_DIR/${sourceDotfile[$i]} ${destination[$i]}
done

# Setting up OSX preferences.
source ./.osx.sh
