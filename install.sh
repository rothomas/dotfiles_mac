#!/bin/sh

case `uname` in
Darwin)
  # curl should always be installed here
  ;;
Linux)
  . /etc/os-release
  ;;
*)
  echo "Unsupported OS platform. Supported platforms are Linux and Darwin. Cannot continue."
  exit 1
  ;;
esac

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

run_privileged() {
  if [ `whoami` = 'root' ]; then
    $@
  else
    sudo $@
  fi
}

install_curl() {
  case $ID in
  centos)
    package_manager=yum
    ;;
  rhel)
    package_manager=yum
    ;;
  fedora)
    pakcage_manager=yum
    ;;
  ubuntu)
    package_manager=apt
    ;;
  debian)
    package_manager=apt
    ;;
  arch)
    package_manager=pacman
    ;;
  alpine)
    package_manager=apk
    ;;
  default)
    echo "Unknown OS ID ${ID}. Cannot continue."
    exit 1
    ;;
  esac
  case "${package_manager}" in
  yum)
    run_privileged yum update
    run_privileged yum install -y curl
    ;;
  apt)
    run_privileged apt-get update -y
    run_privileged apt-get install -y curl
    ;;
  pacman)
    run_privileged pacman -Sy curl
    ;;
  apk)
    run_privileged apk add --update curl
    ;;
  *)
    echo "Unknown package manager. Cannot continue."
    exit 1
    ;;
  esac
}

check_prerequisites() {
  installed curl && return 0
  installed wget && return 0
  if [ `whoami` = 'root' ]; then
    install_curl
  elif command -v sudo && sudo -v; then
    install_curl
  else
    echo "Cannot satisfy prerequisites. You must have curl or wget installed, or run as root, or be able to sudo."
    exit 1
  fi
}

>&2 echo "Installing..."
if ! installed chezmoi; then
  check_prerequisites
  >&2 echo "Installing chezmoi"
  chezmoi_script=`download chezmoi.io/get`
  sh -c "${chezmoi_script}" -- init --verbose --apply rothomas
fi
