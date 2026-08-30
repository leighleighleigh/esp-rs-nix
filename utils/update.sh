#!/usr/bin/env bash

nix repl <<-EOF
:l <nixpkgs>
srcs = pkgs.callPackage ./update-hashes.nix {}
# srcs.rust-src-hashes
# srcs.rust-build-hashes
# srcs.esp-gcc-hashes
# srcs.esp-gdb-hashes
# srcs.hashes
builtins.toFile "hashes.json" (builtins.toJSON srcs.hashes)
EOF
