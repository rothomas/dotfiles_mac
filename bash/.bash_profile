
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

if [ -f ~/.rvm.sh ]; then
  source ~/.rvm.sh
fi
if [ -f ~/.nvm.sh ]; then
  source ~/.nvm.sh
fi

eval $(ssh-agent -s)
ssh-add


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
