#!/usr/bin/env bash

for v in "1.90.0.0" "1.89.0.0" "1.88.0.0" "1.87.0.0" "1.86.0.0";
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
