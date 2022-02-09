#!/usr/bin/env bash

export DOTFILES_HOME="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export PLATFORM=$(uname)

if [ $PLATFORM = 'Linux' ]; then
  source ${DOTFILES_HOME}/uninstall-linux.sh
fi

if [ $PLATFORM = 'Darwin' ]; then
  source ${DOTFILES_HOME}/uninstall-osx.sh
fi

source ${DOTFILES_HOME}/uninstall-common.sh

