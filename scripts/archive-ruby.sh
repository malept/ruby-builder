#!/usr/bin/env bash

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

ruby_version="$1"
distro="$("$DIR"/normalize_distro.sh "$2")"

pushd "$HOME/.asdf/installs/ruby"
tar --strip-components=1 -cf "ruby-${ruby_version}_${distro}.tar.xz" "$ruby_version"
popd
