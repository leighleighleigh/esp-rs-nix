{
  rust-build =
    let
      systemNameMap = {
        aarch64-darwin = "aarch64-apple-darwin";
        aarch64-linux = "aarch64-unknown-linux-gnu";
        x86_64-linux = "x86_64-unknown-linux-gnu";
      };
    in
    { system, version }:
    "https://github.com/esp-rs/rust-build/releases/download/v${version}/rust-${version}-${systemNameMap.${system}}.tar.xz";

  rust-src =
    { version }:
    "https://github.com/esp-rs/rust-build/releases/download/v${version}/rust-src-${version}.tar.xz";

  esp-gcc =
    let
      systemNameMap = {
        aarch64-darwin = "aarch64-apple-darwin";
        aarch64-linux = "aarch64-linux-gnu";
        x86_64-linux = "x86_64-linux-gnu";
      };
    in
    {
      system,
      targetarch,
      version,
    }:
    "https://github.com/espressif/crosstool-NG/releases/download/esp-${version}/${targetarch}-esp-elf-${version}-${systemNameMap.${system}}.tar.xz";

  esp-gdb =
    let
      darwinSystemNameMap =
        version:
        if version <= "16.2_20250324" then "aarch64-apple-darwin21.1" else "aarch64-apple-darwin24.5";
      systemNameMapFn = version: {
        x86_64-linux = "x86_64-linux-gnu";
        aarch64-linux = "aarch64-linux-gnu";
        aarch64-darwin = darwinSystemNameMap version;
      };
    in
    {
      system,
      targetarch,
      version,
    }:
    "https://github.com/espressif/binutils-gdb/releases/download/esp-gdb-v${version}/${targetarch}-esp-elf-gdb-${version}-${
      (systemNameMapFn version).${system}
    }.tar.gz";
}
