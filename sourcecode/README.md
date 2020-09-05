# sourcecode

Random custom programs for functionality that wasn't otherwise easily available,
or that I just wanted to do myself. Also contains the `subprojects/` dir for
other projects pulled in as submodules.

The `install.sh` script can install most of these applications when called as
`./install.sh all`. This requires the presence of a [Go](https://golang.org/)
compiler, a C compiler, and development files for the
[BearSSL](https://www.bearssl.org/) library. The `enter-chroot` utility has to
be built and installed separately.
