#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Select the name for this pc
echo -n "Enter the name for this pc: "
read name
scutil --set HostName $name
scutil --set LocalHostName $name

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install Command Line Tools
xcode-select --install

# Brew setup.
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

## Installing apps. ##
# Getting the list of apps from the txts in Apps/.
IFS=$'\n'
brewApp=($(cat ./Apps/brew.txt))
caskApp=($(cat ./Apps/cask.txt))
nodeApp=($(cat ./Apps/node.txt))

# Installing the apps in the correct order
brew install ${brewApp[@]}
brew cask install ${caskApp[@]}
npm install -g ${nodeApp[@]}

# brew cask alfred link
brew cleanup

# Installing atom packeges
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

# Removing Chromes's apps
rm -rf ~/Applications/Chrome\ Canary\ Apps.localized
rm -rf ~/Applications/Chrome\ Apps.localized/Default\ apdfllckaahabafndbhieahigkjlhalf.app/
rm -rf ~/Applications/Chrome\ Apps.localized/Default\ coobgpohoikkiipiblmjeljniedjpjpf.app/
rm -rf ~/Applications/Chrome\ Apps.localized/Default\ fahmaaghhglfmonjliepjlchgpgfmobi.app/
rm -rf ~/Applications/Chrome\ Apps.localized/Default\ pjkljhegncpnkpknbcohdijeoejaedia.app/
rm -rf ~/Applications/Chrome\ Apps.localized/Icon^M
rm -rf ~/Applications/Chrome\ Apps.localized/app_list.app/
# TODO remove other chrome apps

## Symlinking dotfiles. ##
# Getting source and destination for each dotfile in DF/.
IFS=$'\n'
sourceDotfile=($(cat ./DF/source.txt))
destination=($(cat ./DF/destination.txt))

# Putting the files in the correct position.
length=${#sourceDotfile[@]}
for (( i=0; i<${length}; i++ ));
do
  ln -svfn $DOTFILES_DIR/${sourceDotfile[$i]} "`eval echo ${destination[$i]//>}`"
done

# Setting up OSX preferences.
source ./.osx.sh
