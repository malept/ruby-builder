#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

ruby_version="$1"
distro="$("$DIR"/normalize_distro.sh "$2")"

tar -cf "ruby-${ruby_version}_${distro}.tar.xz" "$HOME/.asdf/installs/ruby/$ruby_version"
