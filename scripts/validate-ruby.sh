#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# shellcheck source=scripts/include/common.sh
source "$DIR/include/common.sh"

expected_version="$1"
actual_version="$(ruby --version | awk '{print $2}')"

if [[ "$expected_version" != "$actual_version" ]]; then
  fail "The actual Ruby version ($actual_version) does not match the expected version ($expected_version)"
fi

location="$(asdf where ruby "$expected_version")"

persist_value ruby_location "$location"
