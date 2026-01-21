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
        version = "1.90.0.0"; # Rust version
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
        pkgs.rust-analyzer
        pkgs.rustup
        pkgs.espflash
        pkgs.pkg-config
        pkgs.stdenv.cc
        #pkgs.systemdMinimal
    ];

    shellHook = ''
    # Add a prefix 'esp-rs' to the shell prompt
    export PS1="(esp-rs)$PS1"

    # This variable is important - it tells rustup where to find the esp toolchain,
    # without needing to copy it into your local ~/.rustup/ folder.
    export RUSTUP_TOOLCHAIN=${esp-rs}
    '';
}
