#!/bin/sh

installed() {
  command -v "$1" >/dev/null
}

download() {
  local url=$1
  if installed curl; then
    curl -o- "$url"
  elif installed wget; then
    wget -qO- "$url"
  else
    >&2 echo "Either wget or curl must be installed. Cannot continue."
    exit 1
  fi
}

if ! installed chezmoi; then
  script=`download chezmoi.io/get`
  sh -c "${chezmoi_script}" -- init --verbose --apply rothomas
fi
