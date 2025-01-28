#!/usr/bin/env bash

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

ruby_version="$1"
distro="$("$DIR"/normalize_distro.sh "$2")"

tar --directory="$HOME/.asdf/installs/ruby/$ruby_version" --create --file "$DIR/../ruby-${ruby_version}_${distro}.tar.xz" .
