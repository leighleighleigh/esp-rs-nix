#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jq -p moreutils
set -eou pipefail

# Get script location (to allow executing this script from outside of utils/ subdir)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

OLD_HASHES="${SCRIPT_DIR}/../esp-rs/hashes.json"
NEW_HASHES="${SCRIPT_DIR}/../esp-rs/new-hashes.json"

# Step 1. Add new URL key entries to the JSON.
# Evalutes ./build-hash-keys.nix, which iterates over all versions to generate all of the required file URLS,
# then prints the result 'hashes' variable as JSON to stdout. This is then validated and formatteed by jq, before being written to the file.
nix eval --impure --expr "let pkgs = import <nixpkgs> {}; srcs = pkgs.callPackage ${SCRIPT_DIR}/build-hash-keys.nix {}; in srcs.hashes" --json | jq > "${NEW_HASHES}"

# Step 2. Iterate over the new-hashes JSON, and try to prefetch and calculate a sha256 hash for each empty value.
# This is done using the 'hash-url.sh' script. A function wrapper then handles the JSON file update process.
fetch_hash() {
    url="${1?}"
    fileHash=$("${SCRIPT_DIR}/hash-url.sh" "${url}")
    cat "${NEW_HASHES}" | URL=$url HASH=$fileHash jq '.[env.URL]=env.HASH' | sponge "${NEW_HASHES}"
}

export SCRIPT_DIR
export NEW_HASHES
export -f fetch_hash
cat "${NEW_HASHES}" | jq -r 'to_entries[] | select(.value == "") | .key' | xargs -I{} -P8 bash -c "fetch_hash {}"

# Replace the old hashes.json file with the new one
mv "${NEW_HASHES}" "${OLD_HASHES}"
