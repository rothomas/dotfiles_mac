#!/usr/bin/env bash

homebrew_install_apt_prereqs() {
  #################################################################################################
  #   APT PLATFORMS (Debian, Ubuntu)
  #################################################################################################
  if [[ "$(apt list build-essential procps curl file git 2>/dev/null | grep -cF '[installed]')" != "5" ]]; then
    echo "Installing apt prerequisites (sudo required)"
    sudo apt -y install build-essential procps curl file git
  fi
}

homebrew_install_yum_prereqs() {
  #################################################################################################
  #   YUM PLATFORMS (CentOS, RHEL, Fedora)
  #################################################################################################
  if [[ "$(yum -C grouplist 'Development Tools' 2>/dev/null | grep -c 'Installed')" == "0" ]]; then
    echo "Installing development tools (sudo required)"
    sudo yum groupinstall -y 'Development Tools'
  fi
  reqs=(procps-ng curl file git)
  if [[ "$(yum list installed procops-ng curl file git 2>/dev/null | grep -c $(uname -m))" != "4" ]]; then
    echo "Installing yum prerequisites (sudo required)"
    sudo yum install -y procops-ng curl file git
  fi
  if [[ "$ID" == "fedora" && "$(yum list installed libxcrypt-compat 2>/dev/null | grep -c $(uname -m))" != "1" ]]; then
    echo "Installing libxcrypt-compat for Fedora (sudo required)"
    sudo yum install -y libxcrypt-compat
  fi
}

homebrew_install_linux_prereqs() {
  source /etc/os-release
  if [[ ! -z "$(command -v apt)" ]]; then
    install_apt_prereqs
  elif [[ ! -z "$(command -v yum)" ]]; then
    install_yum_prereqs
  else
    echo "No supported package manager found for Linux prerequisites"
    exit 1
  fi
}


homebrew_install() {
  if [[ -z "$(command -v brew)" || ! "$(brew --version | head -1)" =~ "^Homebrew" ]]; then
    if [[ "$(uname)" == "Linux" ]]; then
      install_linux_prereqs
    fi

    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

homebrew_install

