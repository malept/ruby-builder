#!/usr/bin/env sh
# This can't be a bash script because alpine doesn't have bash by default

DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd)"

# shellcheck source=scripts/include/common.sh
. "$DIR/include/common.sh"

if test -z "$1" || test -z "$2"; then
  fail "Usage: $0 [distro:version] [ruby_version]"
fi

distro="$1"
ruby_version="$2"
os="$(uname -s)"

if enable_yjit "$ruby_version"; then
  persist_value yjit_arg --enable-yjit
fi

persist_value os "$(echo "$os" | awk '{ print tolower($0) }')"
persist_value arch "$(normalize_arch)"
persist_value distro_name "$(echo "$distro" | cut -d: -f1)"
persist_value distro_version "$(echo "$distro" | cut -d: -f2)"
