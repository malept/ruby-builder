#!/usr/bin/env sh

version="$1"
major_version="$(echo "$version" | cut -d. -f1)"
minor_version="$(echo "$version" | cut -d. -f2)"

# shellcheck disable=SC2235
# Why: don't care about subshell overhead in this case.
if test "$major_version" -gt 3 || (test "$major_version" -eq 3 && test "$minor_version" -ge 2); then
  exit 0
else
  exit 1
fi
