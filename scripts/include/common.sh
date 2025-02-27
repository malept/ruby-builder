#!/usr/bin/env sh

# Determines whether a given Ruby version has the --enable-yjit flag
# in its ./configure script.
enable_yjit() {
  version="$1"
  major_version="$(echo "$version" | cut -d. -f1)"
  minor_version="$(echo "$version" | cut -d. -f2)"

  # Why: don't care about subshell overhead in this case.
  # shellcheck disable=SC2235
  if test "$major_version" -gt 3 || (test "$major_version" -eq 3 && test "$minor_version" -ge 2); then
    return 0
  else
    return 1
  fi
}

# Prints the provided message to stderr and exits with return code 1.
fail() {
  echo "$1" >&2
  exit 1
}

# Persists a value to the detected CI provider. On GitHub Actions, add
# the name to the outputs of the given job step. On all other CI
# providers, add the uppercased + prefixed with `RUBY_BUILDER_`
# environment variable to the bash environment (`BASH_ENV`).
persist_value() {
  name="$1"
  value="$2"
  if test -n "$GITHUB_OUTPUT"; then
    echo "$name=$value" >>"$GITHUB_OUTPUT"
  else
    echo "export RUBY_BUILDER_$(echo "$name" | awk '{ print toupper($0) }')=\"$value\"" >>"$BASH_ENV"
  fi
}
