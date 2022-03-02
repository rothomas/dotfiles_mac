#!/usr/bin/env bash

source "{{ .chezmoi.sourceDir }}/.helpers/prereq_functions"

if installed nvm; then
  (
    cd "$NVM_DIR"
    git fetch --tags origin
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  ) && \. "$NVM_DIR/nvm.sh"
  cd -
else
  download_run_script https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh
fi
