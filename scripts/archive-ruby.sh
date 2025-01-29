#!/usr/bin/env bash

set -eo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
BUILDER_DIR="$DIR/.."

ruby_version="$1"
distro="$("$DIR"/normalize_distro.sh "$2")"

binary_tarball_filename() {
  # Uses short args here because of macOS compatibility. Equivalent
  # long arguments documented in README.md.
  local kernel
  kernel="$(uname -s)"
  echo "ruby-${ruby_version}_${kernel,,}-$(uname -m)_${distro}.tar.xz"
}

tar_filename="$BUILDER_DIR/$(binary_tarball_filename)"

tar --directory="$HOME/.asdf/installs/ruby/$ruby_version" --create \
  --file "$tar_filename" .

ls -l "$tar_filename"

echo "ruby_tarball=$tar_filename" >>"$GITHUB_OUTPUT"
