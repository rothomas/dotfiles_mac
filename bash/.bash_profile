
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

if [ -f ~/.rvm.sh ]; then
  source ~/.rvm.sh
fi
if [ -f ~/.pyenv.sh ]; then
  source ~/.pyenv.sh
fi
if [ -f ~/.nvm.sh ]; then
  source ~/.nvm.sh
fi

eval $(ssh-agent -s)
ssh-add

