{
  pkgs,
  lib,
  ...
}:
let
  # Top-level list of supported versions to terate.
  inherit (import ./versions.nix)
    systems
    targets
    rustc_versions
    crosstool_versions
    binutils_versions
    ;

  # Contains functions for each package, which build the source urls
  srcURLBuilders = (import ../esp-rs/urls.nix);

  # Current hashes file, where we can get the already-known hash values.
  oldHashes = builtins.fromJSON (builtins.readFile ../esp-rs/hashes.json);
in
rec {
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

  urls = rust-src-urls ++ rust-build-urls ++ esp-gcc-urls ++ esp-gdb-urls;

  hashes = builtins.listToAttrs (
    lib.lists.forEach urls (u: {
      "name" = "${u}";
      "value" = if (oldHashes ? "${u}") then oldHashes.${u} else "";
    })
  );
}
