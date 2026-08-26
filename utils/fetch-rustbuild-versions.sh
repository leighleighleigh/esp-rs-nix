#!/usr/bin/env bash

for v in "1.98.0.0" "1.97.0.0" "1.96.0.0" "1.95.0.0" "1.94.0.2" "1.94.0.1" "1.94.0.0"
do
    echo "\"${v}\" = {"
    for t in "x86_64-unknown-linux-gnu" "aarch64-unknown-linux-gnu" "aarch64-apple-darwin";
    do
        url="https://github.com/esp-rs/rust-build/releases/download/v${v}/rust-${v}-${t}.tar.xz"
        # hash the file then convert to SRI format
        h=$(nix-prefetch-url --unpack --type sha256 "${url}" 2>/dev/null)
        srihash=$(nix-hash --type sha256 --to-sri "${h}")
        echo "  \"${t}\" = \"${srihash}\";"
    done
    echo "};"
done
