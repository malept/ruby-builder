#!/usr/bin/env sh

set -e

DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd)"

distro="$1"
distro_name="$(echo "$distro" | cut -d: -f1)"
version="$2"

extra_alpine_pkgs=""
extra_ubuntu_pkgs=""
if test -n "$ACT"; then
  # When using act, needs nodejs. Not necessary in hosted GH actions runner.
  extra_alpine_pkgs="$extra_alpine_pkgs nodejs"
  extra_ubuntu_pkgs="$extra_ubuntu_pkgs nodejs"
fi

if "$DIR"/enable_yjit.sh "$version"; then
  extra_alpine_pkgs="$extra_alpine_pkgs rust"
  extra_ubuntu_pkgs="$extra_ubuntu_pkgs rustc"
  echo "yjit_arg=--enable-yjit" >>"$GITHUB_OUTPUT"
fi

case "$distro_name" in
alpine)
  # shellcheck disable=SC2086
  apk add bash curl git build-base bzip2 libffi-dev openssl-dev ncurses-dev gdbm-dev zlib-dev readline-dev yaml-dev $extra_alpine_pkgs
  ;;
ubuntu)
  apt-get update
  # shellcheck disable=SC2086
  apt-get install -y git curl autoconf patch build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev $extra_ubuntu_pkgs
  ;;
*)
  echo "Unsupported distro ($distro)" >&2
  exit 1
  ;;
esac
