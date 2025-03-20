#!/usr/bin/env bash

set -eo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
BUILDER_DIR="$(
  cd "$DIR"/..
  pwd -P
)"

# shellcheck source=scripts/include/common.sh
source "$DIR/include/common.sh"

distro_name="$1"
distro_version="$2"
ruby_version="$3"

binary_tarball_filename() {
  # Uses short args here because of macOS compatibility. Equivalent
  # long arguments documented in README.md.
  local kernel
  kernel="$(uname -s)"
  echo "ruby-${ruby_version}_${kernel,,}-$(uname -m)_${distro_name}-${distro_version}.tar.xz"
}

tarball_filename="$(binary_tarball_filename)"
tarball_path="$BUILDER_DIR/$tarball_filename"

tar --xz --directory="$HOME/.asdf/installs/ruby/$ruby_version" --create \
  --file "$tarball_path" .

ls -l "$tarball_path"

if ! file "$tarball_path" | grep -q 'XZ compressed data'; then
  fail "Tarball is not compressed with 'xz'"
fi

persist_value ruby_tarball_filename "$tarball_filename"
persist_value ruby_tarball_path "$tarball_path"
