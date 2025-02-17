#!/usr/bin/env bash

if [[ -z $1 ]]; then
  echo "Usage: $0 [distro:version]" >&2
  exit 1
fi

echo "${1//:/-}"
