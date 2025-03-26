#!/usr/bin/env sh
# This can't be a bash script because alpine doesn't have bash by default

set -e

DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd)"

# shellcheck source=scripts/include/common.sh
. "$DIR/include/common.sh"

distro_name="$1"
version="$2"

# xz is used for creating the tarballs
extra_alpine_pkgs="xz file"
extra_ubuntu_pkgs="xz-utils file"
if test -n "$ACT"; then
  # When using act, needs nodejs. Not necessary in hosted GH actions runner.
  extra_alpine_pkgs="$extra_alpine_pkgs nodejs"
  extra_ubuntu_pkgs="$extra_ubuntu_pkgs nodejs"
fi

if enable_yjit "$version"; then
  extra_alpine_pkgs="$extra_alpine_pkgs rust"
  extra_ubuntu_pkgs="$extra_ubuntu_pkgs rustc"
fi

case "$distro_name" in
alpine)
  # shellcheck disable=SC2086
  apk add bash curl git build-base bzip2 libffi-dev openssl-dev ncurses-dev gdbm-dev zlib-dev readline-dev yaml-dev $extra_alpine_pkgs
  ;;
ubuntu)
  apt-get update
  apt-get install -y curl
  if test -n "$ACT"; then
    # Install Node.js LTS from Nodesource for consistency, actions need sufficiently new version
    # (versus what is in Ubuntu's first party repo)
    curl -fsSL https://deb.nodesource.com/setup_lts.x -o nodesource_setup.sh
    bash nodesource_setup.sh
    rm nodesource_setup.sh
  fi
  # shellcheck disable=SC2086
  apt-get install -y git autoconf patch build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev $extra_ubuntu_pkgs
  ;;
*)
  fail "Unsupported distro ($distro_name)"
  ;;
esac
