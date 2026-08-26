#!/usr/bin/env bash

for v in "1.98.0.0" "1.97.0.0" "1.96.0.0" "1.95.0.0" "1.94.0.2" "1.94.0.1" "1.94.0.0"
do
    url="https://github.com/esp-rs/rust-build/releases/download/v${v}/rust-src-${v}.tar.xz"
    # hash the file then convert to SRI format
    h=$(nix-prefetch-url --unpack --type sha256 "${url}" 2>/dev/null)
    srihash=$(nix-hash --type sha256 --to-sri "${h}")
    echo "\"${v}\" = \"${srihash}\";"
done
