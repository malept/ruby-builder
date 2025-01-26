#!/usr/bin/env bash

distro="$1"

distro_name="$(cut -d: -f1 <<<"$distro")"
#distro_version="$(cut -d: -f2 <<<"$distro")"

case "$distro_name" in
ubuntu)
  apt-get install -y git
  ;;

esac
