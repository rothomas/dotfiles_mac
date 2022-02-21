#!/usr/bin/env bash

echo "I AM IN $(pwd)"
. .helpers/prereq_functions

homebrew_install_apt_prereqs() {
  #################################################################################################
  #   APT PLATFORMS (Debian, Ubuntu)
  #################################################################################################
  require build-essential
  require procps
  require curl
  require file
  require git
}

homebrew_install_yum_prereqs() {
  #################################################################################################
  #   YUM PLATFORMS (CentOS, RHEL, Fedora)
  #################################################################################################
  if [[ "$(yum -C grouplist 'Development Tools' 2>/dev/null | grep -c 'Installed')" == "0" ]]; then
    echo "Installing development tools (sudo required)"
    sudo yum groupinstall -y 'Development Tools'
  fi
  require procps-ng
  require curl
  require file
  require git
  if [[ "$ID" == "fedora" && "$(yum list installed libxcrypt-compat 2>/dev/null | grep -c $(uname -m))" != "1" ]]; then
    require libxcrypt-compat
  fi
}

homebrew_install_linux_prereqs() {
  source /etc/os-release
  if [[ ! -z "$(command -v apt)" ]]; then
    homebrew_install_apt_prereqs
  elif [[ ! -z "$(command -v yum)" ]]; then
    homebrew_install_yum_prereqs
  else
    echo "No supported package manager found for Linux prerequisites"
    exit 1
  fi
}

homebrew_install() {
  if [[ -z "$(command -v brew)" || ! "$(brew --version | head -1)" =~ "^Homebrew" ]]; then
    if [[ "$(uname)" == "Linux" ]]; then
      homebrew_install_linux_prereqs
    fi

    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

homebrew_install

