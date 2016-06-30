#!/bin/bash

##Expect password prompts

##Set some paths
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentDIR="$(dirname "$DIR")"

##Install command-line tools for Xcode:
xcode-select --install

##Now Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

##Now install stuff using Homebrew
brew install caskroom/cask/brew-cask
brew install socat
brew cask install xquartz
brew cask install dockertoolbox

##Create the docker machine
docker-machine create --driver "virtualbox" cymer

##Start the docker machine
docker-machine start cymer

##Allow docker commands to be used in the terminal
eval "$(docker-machine env cymer)"

##Download CymeR
docker pull bmuchmore/cymer

##Give the CymeR.command file run permissions
chmod +x $DIR/CymeR.command

##Give the commit.command file run permissions
chmod +x $DIR/commit.command

##Give the Update.command file run permissions
chmod +x $DIR/Update.command

##Give the Uninstall.command file run permissions
chmod +x $DIR/BaseFiles/Uninstall/Uninstall.command
