#!/usr/bin/env bash

export DOTFILES_HOME=$(dirname "$0")
export PLATFORM=$(uname)

echo 'Attempting to get sudo access.  Your password may be required.  Some features may not be available if you are not a sudoer.'
sudo -v
if [ $? -eq 0 ]; then
  export SUDOER=1
else
  export SUDOER=0
fi

if [ $PLATFORM == 'Linux' ]; then
  source ${DOTFILES_HOME}/install-linux.sh
fi

if [ $PLATFORM == 'Darwin' ]; then
  source ${DOTFILES_HOME}/install-osx.sh
fi

source ${DOTFILES_HOME}/install-common.sh

