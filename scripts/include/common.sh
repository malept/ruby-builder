#!/usr/bin/env sh

# Determines whether a given Ruby version has the --enable-zjit flag
# in its ./configure script.
enable_zjit() {
  version="$1"
  major_version="$(echo "$version" | cut -d. -f1)"

  # ZJIT exists in Ruby 4.0 and later.
  test "$major_version" -ge 4
}

# Prints the provided message to stderr and exits with return code 1.
fail() {
  echo "$1" >&2
  exit 1
}

# Converts stdin to lowercase.
to_lowercase() {
  awk '{ print tolower($0) }'
}

# Normalizes the value of `uname -m` (AKA `uname --machine` with GNU coreutils).
normalize_arch() {
  arch="$(uname -m | to_lowercase)"
  case "$arch" in
  x86_64 | amd64) echo amd64 ;;
  arm64 | aarch64) echo aarch64 ;;
  *) fail "Unsupported arch: $arch" ;;
  esac
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
