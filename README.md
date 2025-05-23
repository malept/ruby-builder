# Ruby binary builder

Builds relocatable binaries of the Ruby language and uploads them to
a GitHub release.

Enables YJIT in Ruby >= 3.2.0.

## Binary tarball

The file format is as follows:

```shell
ruby-${version}_${os}-${arch}_${distro}-${distro_version}.tar.xz
```

where:

* `version`: CRuby version.
* `os`: The lowercase value of `uname -s` (AKA `uname --kernel-name` with GNU coreutils).
* `arch`: The value of `uname -m` (AKA `uname --machine` with GNU coreutils).
* `distro`: The value of the `ID` environment variable when sourced from `/etc/os-release` or similar. Defaults to `unknown` on Linux and `none` on macOS.
* `distro_version`: The value of the `VERSION_ID` environment variable when sourced from `/etc/os-release` or similar. Defaults to `unknown` on Linux and `none` on macOS.
