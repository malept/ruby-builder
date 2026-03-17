#!/usr/bin/env bash

set -eo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# shellcheck source=scripts/include/common.sh
source "$DIR/include/common.sh"

major_minor="${1:-}"

cd versions/"$major_minor"

actual_version="$(ruby --version | awk '{print $2}' | cut -d p -f1)"

if ! [[ $actual_version == "$major_minor"* ]]; then
  fail "The actual Ruby version ($actual_version) does not start with '$major_minor'"
fi

location="$(mise where ruby@"$major_minor")"

persist_value install_location "$location"
