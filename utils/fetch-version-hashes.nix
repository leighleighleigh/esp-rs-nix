{
  pkgs,
  lib,
  ...
}:
let
  # Top-level list of supported versions.
  # These are used to pre-fetch source file hashes, stored in hashes.json.
  inherit (import ./versions.nix)
    systems
    targets
    rustc_versions
    crosstool_versions
    binutils_versions
    ;

  # Contains functions for each package, which build the source urls
  srcURLBuilders = (import ../esp-rs/urls.nix);

  # Current hashes file, this allows us to skip files we already have hashed.
  oldHashes = builtins.fromJSON (builtins.readFile ../esp-rs/hashes.json);

  # Function which takes a URL and returns it's hash.
  # If the URL does not exist in the oldHashes map,
  # then it will be downloaded and calculated using a runCommand invocation.
  urlHashFunction =
    url:
    if (oldHashes ? "${url}") then
      if (builtins.stringLength oldHashes.${url}) == 0 then
        (lib.warn "Found empty hash for URL: ${url}") oldHashes.${url}
      else
        oldHashes.${url}
    else
      let
        hashCmd =
          pkgs.runCommand "fetch-hash-${url}"
            {
              nativeBuildInputs = [
                pkgs.nix
                pkgs.nix-prefetch
              ];
              urlToHash = "${url}";
            }
            ''echo -n "" >$out && nix-hash --type sha256 --to-sri "$(nix-prefetch-url --unpack --type sha256 "''${urlToHash}" 2>/dev/null)" >>$out || exit 0'';
      in
      builtins.trace "Fetching hash for ${url}..." (builtins.readFile (hashCmd));
in
rec {
  # Step 1. Build the URLs for each package, for all versions.
  rust-src-urls = lib.lists.forEach rustc_versions (v: srcURLBuilders.rust-src { version = v; });

  rust-build-urls = lib.lists.flatten (
    lib.lists.forEach systems (
      s:
      lib.lists.forEach rustc_versions (
        v:
        srcURLBuilders.rust-build {
          system = s;
          version = v;
        }
      )
    )
  );

  esp-gcc-urls = lib.lists.flatten (
    lib.lists.forEach systems (
      s:
      lib.lists.forEach targets (
        t:
        lib.lists.forEach crosstool_versions (
          v:
          srcURLBuilders.esp-gcc {
            system = s;
            targetarch = t;
            version = v;
          }
        )
      )
    )
  );

  esp-gdb-urls = lib.lists.flatten (
    lib.lists.forEach systems (
      s:
      lib.lists.forEach targets (
        t:
        lib.lists.forEach binutils_versions (
          v:
          srcURLBuilders.esp-gdb {
            system = s;
            targetarch = t;
            version = v;
          }
        )
      )
    )
  );

  # Concat all URLS together
  urls = rust-src-urls ++ rust-build-urls ++ esp-gcc-urls ++ esp-gdb-urls;

  # builtins.mapAttrs (name: value: value * 10) { a = 1; b = 2; }
  hashes = builtins.listToAttrs (
    lib.lists.forEach urls (u: {
      "name" = "${u}";
      "value" = urlHashFunction u;
    })
  );
}
