#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jq
set -eou pipefail

# Get script location (to allow executing this script from outside of utils/ subdir)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

OLD="${SCRIPT_DIR}/../esp-rs/hashes.json"
NEW="${SCRIPT_DIR}/../esp-rs/new-hashes.json"

# Prints the result to stdout, which are saved to new-hashses.json
nix eval --impure --expr "let pkgs = import <nixpkgs> {}; srcs = pkgs.callPackage ${SCRIPT_DIR}/fetch-version-hashes.nix {}; in srcs.hashes" --json | jq > "${NEW}"

# Replace the old file with the new one
mv "${NEW}" "${OLD}"
