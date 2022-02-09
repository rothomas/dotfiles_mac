#!/usr/bin/env bash

echo 'Removing local configuration'

source ${DOTFILES_HOME}/node/uninstall
source ${DOTFILES_HOME}/python/uninstall
source ${DOTFILES_HOME}/ruby/uninstall
source ${DOTFILES_HOME}/vim/uninstall
source ${DOTFILES_HOME}/gpg2/uninstall
source ${DOTFILES_HOME}/zsh/uninstall
source ${DOTFILES_HOME}/git/uninstall
source ${DOTFILES_HOME}/bash/uninstall

