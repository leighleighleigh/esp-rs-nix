{
  pkgs,
  lib,
  ...
}:
let
  # All top-level lists
  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];

  targets = [
    "xtensa"
    "riscv32"
  ];

  rustc_versions = [
    "1.98.0.0"
    "1.97.0.0"
    "1.96.0.0"
    "1.95.0.0"
    "1.94.0.2"
    "1.94.0.1"
    "1.94.0.0"
    "1.93.0.0"
    "1.92.0.0"
    "1.91.1.0"
    "1.90.0.0"
    "1.89.0.0"
    "1.88.0.0"
    "1.87.0.0"
    "1.86.0.0"
  ];

  crosstool_versions = [
    "16.1.0_20260609"
    "15.2.0_20251204"
    "15.2.0_20250920"
    "15.1.0_20250607"
  ];

  binutils_versions = [
    "17.1_20260402"
    "16.3_20250913"
    "16.2_20250324"
  ];

  # Contains functions for each package, which build the source urls
  srcURLBuilders = (import ../esp-rs/urls.nix);

  # OLD hashses file, this will be migrated later
  oldHashes = (import ../esp-rs/old-versions.nix);
in
rec {
  # {version}
  rust-src-urls = lib.lists.forEach rustc_versions (v: srcURLBuilders.rust-src { version = v; });
  rust-src-hashes = builtins.listToAttrs (
    lib.lists.forEach rustc_versions (v: {
      "name" = srcURLBuilders.rust-src { version = v; };
      "value" = oldHashes.rust-src.${v};
    })
  );

  # {system, version}
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
  rust-build-hashes = builtins.listToAttrs (
    lib.lists.flatten (
      lib.lists.forEach systems (
        s:
        lib.lists.forEach rustc_versions (v: {
          "name" = srcURLBuilders.rust-build {
            system = s;
            version = v;
          };
          "value" = oldHashes.rust-build.${v}.${oldHashes.rust-build.systemNameMap.${s}};
        })
      )
    )
  );

  # { system, targetarch, version }
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
  esp-gcc-hashes = builtins.listToAttrs (
    lib.lists.flatten (
      lib.lists.forEach systems (
        s:
        lib.lists.forEach targets (
          t:
          lib.lists.forEach crosstool_versions (v: {
            "name" = srcURLBuilders.esp-gcc {
              system = s;
              targetarch = t;
              version = v;
            };
            "value" = oldHashes.esp-gcc.${v}.${t}.${oldHashes.esp-gcc.systemNameMap.${s}};
          })
        )
      )
    )
  );

  # { system, targetarch, version }
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

  esp-gdb-hashes = builtins.listToAttrs (
    lib.lists.flatten (
      lib.lists.forEach systems (
        s:
        lib.lists.forEach targets (
          t:
          lib.lists.forEach binutils_versions (v: {
            "name" =

              srcURLBuilders.esp-gdb {
                system = s;
                targetarch = t;
                version = v;
              };

            "value" = oldHashes.esp-gdb.${v}.${t}.${oldHashes.esp-gdb.systemNameMap.${v}.${s}};
          })
        )
      )
    )
  );

  # Concat all hashes together 
  hashes = rust-build-hashes // rust-src-hashes // esp-gcc-hashes // esp-gdb-hashes;
}
