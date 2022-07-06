#!/bin/sh

##############################################################################
# NOTE: We cannot assume bash in a bootstrap situation, especially in a
#       container, so this script must use Bourne shell syntax throughout.
#       Bash is installed ASAP in the chezmoi scripts, so except as noted
#       bash syntax will be accepted in everything else in .chezmoiscripts.
#
# This script aims to be maximally robust to initial conditions. We need
# chezmoi to already be downloaded and on PATH, or we need curl or wget so
# we can download it, and if neither of those are installed, we need
# to be either root or a sudoer to install curl.
##############################################################################

export PLATFORM=`uname`
[ -f /etc/os-release ] && . /etc/os-release
# Known os releases used to determine package manager.
package_manager_centos=yum
package_manager_rhel=yum
package_manager_fedora=yum
package_manager_ubuntu=apt
package_manager_debian=apt
package_manager_arch=pacman
package_manager_alpine=apk
# Set the platform package manager, if relevant.
eval package_manager="\${package_manager_${ID}}" 

install_curl_yum="yum update && yum install -y curl"
install_curl_apt="apt-get update -y && apt-get install -y curl"
install_curl_apk="apk add --update curl"
install_curl_pacman="pacman -Sy curl"
eval install_curl="\${install_curl_${package_manager}}"

installed() {
  # Syntactic sugar for the below.
  command -v "$1" >/dev/null
}

fail() {
  # General exit with a message.
  >&2 echo "${1}"
  exit 1
}

download() {
  # Download a URL using curl or wget, if available.
  local url=$1
  if installed curl; then curl -Lso- "$url"
  elif installed wget; then wget -qO- "$url"
  else fail "Either wget or curl must be installed. Cannot continue."
  fi
}

check_prerequisites() {
  # Darwin definitely has curl available.
  [ "${PLATFORM}" = 'Darwin' ] && return 0
  # If it's not Darwin, it must be Linux or we don't know what to do.
  [ "${PLATFORM}" = 'Linux' ] || fail "Unsupported OS platform: ${PLATFORM}. Cannot continue."
  # If curl is available we're good.
  installed curl && return 0
  # If wget is available we're good.
  installed wget && return 0
  # Can only install curl if we know the package manager.
  [ -z "${package_manager}" ] && "Cannot identify package manager for ${ID}. Cannot continue."
  # If we're running as root, sudo doesn't need to exist.
  if [ `whoami` = 'root' ]; then /bin/sh -c "${install_curl}"
  # If we're running as non-root we'll need to be sudoers.
  elif installed sudo && sudo -v; then sudo /bin/sh -c "${install_curl}"
  # Out of options.
  else fail "Cannot satisfy prerequisites. You must have curl or wget installed, or run as root, or be able to sudo."
  fi
}

get_fullname() {
  if [ "${PLATFORM}" = 'Darwin' ]; then
    id -F  
  elif [ "${PLATFORM}" = 'Linux' ]; then
    getent passwd `whoami` | cut -d: -f5
  fi
}

install_chezmoi() {
  check_prerequisites
  >&2 echo "Prerequisites up-to-date. Downloading chezmoi install script."
  chezmoi_script=`download chezmoi.io/get`
  >&2 echo "Running chezmoi install script."
  sh -c "${chezmoi_script}" -- init --use-builtin-git true --verbose --apply rothomas
}

export CHEZMOI_FULLNAME=`get_fullname`
if installed chezmoi; then
  >&2 echo "Updating chezmoi..."
  chezmoi update --init
else
  >&2 echo "Bootstrapping chezmoi..."
  install_chezmoi
fi

