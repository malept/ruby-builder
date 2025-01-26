#!/usr/bin/env sh

set -e

distro="$1"

distro_name="$(echo "$distro" | cut -d: -f1)"
#distro_version="$(cut -d: -f2 <<<"$distro")"

case "$distro_name" in
alpine)
  apk add bash curl git build-base bzip2 libffi-dev openssl-dev ncurses-dev gdbm-dev zlib-dev readline-dev yaml-dev
  ;;
ubuntu)
  apt-get update
  apt-get install -y git curl autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
  ;;
*)
  echo "Unsupported distro ($distro)" >&2
  exit 1
  ;;
esac
