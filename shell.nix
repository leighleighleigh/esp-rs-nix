{
  pkgs ? import <nixpkgs> {}
}:
let 
    # Uses this folder as the source for esp-rs-nix (in-repo nix-shell)
    esp-rs-src = pkgs.lib.sources.cleanSource ./.;

    # If using this shell.nix out-of-repo, change esp-rs-src to something similar to:
    # esp-rs-src = builtins.fetchTarball "https://github.com/leighleighleigh/esp-rs-nix/archive/main.tar.gz";

    # This will build esp-rs-src, chosen above
    esp-rs = pkgs.callPackage "${esp-rs-src}/esp-rs/default.nix" {
        pkgs = pkgs;
        version = "1.92.0.0"; # Rust version
        crosstool-version = "15.2.0_20250920"; # Cross-compiler toolchain version (GCC)
        binutils-version = "16.3_20250913"; # Binutils version (GDB)
    };

    # OpenOCD fork
    #esp-openocd = pkgs.callPackage "${esp-rs-src}/esp-rs/esp-openocd.nix" {};
in
pkgs.mkShell rec {
    name = "esp-rs-nix";
    
    # You may wish to change these build inputs for your application
    buildInputs = [
        esp-rs
        #rust-analyzer
        #rustup
        #espflash
        pkgs.pkg-config
        pkgs.stdenv.cc
    ];
}
