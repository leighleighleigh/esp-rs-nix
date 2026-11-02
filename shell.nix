{
  pkgs ? import <nixpkgs> { },
}:
let
  # If using this shell.nix in-repo (e.g. for CI), use relative path to src.
  esp-rs-src = pkgs.lib.sources.cleanSource ./.;

  # If using this shell.nix out-of-repo, change esp-rs-src to something similar to:
  # esp-rs-src = builtins.fetchTarball "https://github.com/leighleighleigh/esp-rs-nix/archive/main.tar.gz";

  # This will build esp-rs-src, chosen above.
  # The toolchain versions may be overidden, if desired.
  esp-rs = (pkgs.callPackage "${esp-rs-src}/package.nix" { }).override {
    # (Optional) Override the default rustc version
    #rustc-version = "1.95.0.0";
    # (Optional) Override the default cross-compiler (GCC) toolchain version
    #crosstool-version = "16.1.0_20260609";
    # (Optional) Override the default binutils (GDB) version
    #binutils-version = "17.1_20260402";
  };
in
pkgs.mkShell rec {
  name = "esp-rs-nix";

  packages = [ esp-rs ] ++ [
    # You may wish to change these build inputs for your application
    pkgs.rust-analyzer
    pkgs.rustup
    pkgs.espflash
    pkgs.pkg-config
    pkgs.stdenv.cc
  ];
  
  shellHook = ''
    # Add a prefix to the shell prompt
    export PS1="(${name})$PS1"
    # This variable is important - it tells rustup where to find the esp toolchain,
    # without needing to copy it into your local ~/.rustup/ folder.
    export RUSTUP_TOOLCHAIN=${esp-rs}
  '';
}
