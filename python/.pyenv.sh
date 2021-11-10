function pyenv_init {
  homebrew_install=0
  if [ "$(uname)" = 'Darwin' ] && [ -f $(which brew) ]; then
    homebrew_install=$(brew list | grep pyenv | wc -l)
  fi

  case $1 in
    "--bash_profile")
      ;;
   "--bashrc")
      eval "$(pyenv init -)"
      pyenv virtualenvwrapper
      ;;
    "--profile")
      if [ $homebrew_install = "0" ]; then
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
      fi
      eval "$(pyenv init --path)"
      ;;
    "--zprofile")
      if [ $homebrew_install = "0" ] ;then
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
      fi
      eval "$(pyenv init --path)"
      ;;
    "--zshrc")
      eval "$(pyenv init -)"
      pyenv virtualenvwrapper
      ;;
     *)
      ;;
  esac
}

