#!/usr/bin/env bash

echo 'Running common configuration'

source ${DOTFILES_HOME}/bash/install
source ${DOTFILES_HOME}/git/install
source ${DOTFILES_HOME}/zsh/install
source $(DOTFILES_HOME)/gpg/install
source $(DOTFILES_HOME)/vim/install
source $(DOTFILES_HOME)/ruby/install
source $(DOTFILES_HOME)/python/install
source $(DOTFILES_HOME)/node/install

