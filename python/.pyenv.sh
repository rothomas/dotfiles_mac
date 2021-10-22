#!/usr/bin/env bash

if [ $PLATFORM == 'Darwin' ]; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
else
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
pyenv virtualenvwrapper

