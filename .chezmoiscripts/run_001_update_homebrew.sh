#!/usr/bin/env bash
echo "start $0"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew update
brew upgrade
brew cleanup
echo "end $0"

