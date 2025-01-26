#!/usr/bin/env bash

ruby_version="$1"
distro="${2//:/-}"

tar -cf "ruby-${ruby_version}_${distro}.tar.xz" "$HOME/.asdf/installs/ruby/$ruby_version"
