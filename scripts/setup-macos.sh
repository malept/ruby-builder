#!/usr/bin/env sh

set -e

DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd)"
version="$1"

# shellcheck source=scripts/include/common.sh
. "$DIR/include/common.sh"

# xz is used for creating the tarballs
# rust is for YJIT/ZJIT
extra_brew_pkgs="xz rust"

# List from: https://github.com/rbenv/ruby-build/wiki#macos
# shellcheck disable=SC2086
brew install openssl@3 readline libyaml gmp autoconf $extra_brew_pkgs
