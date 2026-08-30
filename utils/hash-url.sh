#!/usr/bin/env bash

url="${1?}"

echo "Fetching ${url}..." >&2
prefetchResult=$(nix-prefetch-url --unpack --type sha256 "${url}" 2>/dev/null)
ret="$?"

# Handle the case where e.g. the URL does not exist.
if ! [ "${ret}" -eq 0 ];
then
    # echo "nix-prefetch-url returned ${ret} for URL: '${url}'" >&2
    echo -n ""
    exit 0
fi

nix-hash --type sha256 --to-sri "${prefetchResult}" 