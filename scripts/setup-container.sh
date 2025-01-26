#!/usr/bin/env bash

set -euo pipefail

distro="$1"

distro_name="$(cut -d: -f1 <<<"$distro")"
#distro_version="$(cut -d: -f2 <<<"$distro")"

case "$distro_name" in
ubuntu)
  apt-get update
  apt-get install -y git curl
  ;;

esac
