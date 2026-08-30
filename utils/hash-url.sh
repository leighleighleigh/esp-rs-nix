#!/usr/bin/env bash
url="${1?}" # file URL to download and hash
nix-hash --type sha256 --to-sri "$(nix-prefetch-url --unpack --type sha256 "${url}" 2>/dev/null)" 