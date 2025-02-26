#!/usr/bin/env bash

if [[ -z $1 ]] || [[ -z $2 ]]; then
  echo "Usage: $0 [ruby_version] [distro:version]" >&2
  exit 1
fi

os="$(uname -s)"
ruby_version="$1"
distro="$2"
distro_name="$(echo "$distro" | cut -d: -f1)"
distro_version="$(echo "$distro" | cut -d: -f2)"
ruby_location="$(asdf where ruby "$ruby_version")"

{
  echo "os=${os,,}"
  echo "arch=$(uname -m)"
  echo "distro_name=$distro_name"
  echo "distro_version=$distro_version"
  echo "ruby_location=$ruby_location"
} >>"$GITHUB_OUTPUT"
