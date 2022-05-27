set runtimepath^=~/.vim runtimepath+=~/.vim/after
set termguicolors
let &packpath = &runtimepath

lua require('plugins')

source ~/.vimrc

