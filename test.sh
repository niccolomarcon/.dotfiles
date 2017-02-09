#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# # Removing Chromes's apps
# systemsetup -setremotelogin on
# dseditgroup -o create -q com.apple.access_ssh
# dseditgroup -o edit -a admin -t group com.apple.access_ssh

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

caskApp=($(cat ./Apps/cask.txt))

# Installing the apps in the correct order

brew cask install ${caskApp[@]}
