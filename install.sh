#!/bin/sh

installed() {
  command -v "$1" >/dev/null
}

download() {
  local url=$1
  if installed curl; then
    curl -Lso- "$url"
  elif installed wget; then
    wget -qO- "$url"
  else
    >&2 echo "Either wget or curl must be installed. Cannot continue."
    exit 1
  fi
}

>&2 echo "Installing..."
if ! installed chezmoi; then
  >&2 echo "Installing chezmoi"
  chezmoi_script=`download chezmoi.io/get`
  sh -c "${chezmoi_script}" -- init --verbose --apply rothomas
fi
