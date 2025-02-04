#!/usr/bin/env sh

set -e

DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd)"
version="$1"

extra_brew_pkgs=""
if "$DIR"/enable_yjit.sh "$version"; then
  extra_brew_pkgs="$extra_brew_pkgs rust"
  echo "yjit_arg=--enable-yjit" >>"$GITHUB_OUTPUT"
fi

# List from: https://github.com/rbenv/ruby-build/wiki#macos
# shellcheck disable=SC2086
brew install openssl@3 readline libyaml gmp autoconf $extra_brew_pkgs
