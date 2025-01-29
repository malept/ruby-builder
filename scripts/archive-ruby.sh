#!/usr/bin/env bash

set -eo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
BUILDER_DIR="$(
  cd "$DIR"/..
  pwd -P
)"

ruby_version="$1"
distro="$("$DIR"/normalize_distro.sh "$2")"

binary_tarball_filename() {
  # Uses short args here because of macOS compatibility. Equivalent
  # long arguments documented in README.md.
  local kernel
  kernel="$(uname -s)"
  echo "ruby-${ruby_version}_${kernel,,}-$(uname -m)_${distro}.tar.xz"
}

tarball_filename="$(binary_tarball_filename)"
tarball_path="$BUILDER_DIR/$tarball_filename"

tar --directory="$HOME/.asdf/installs/ruby/$ruby_version" --create \
  --file "$tarball_path" .

ls -l "$tarball_path"

echo "ruby_tarball_filename=$tarball_filename" >>"$GITHUB_OUTPUT"
echo "ruby_tarball_path=$tarball_path" >>"$GITHUB_OUTPUT"
