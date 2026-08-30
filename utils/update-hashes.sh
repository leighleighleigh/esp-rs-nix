#!/usr/bin/env bash

# Prints the result to stdout, to be tee-ed into ../esp-rs/hashes.json
nix eval --impure --expr 'let pkgs = import <nixpkgs> {}; srcs = pkgs.callPackage ./fetch-version-hashes.nix {}; in srcs.hashes' --json
