{ pkgs ? import <nixpkgs> {}}:
let 
    # source version
    esp-rs = pkgs.callPackage ../esp-rs/default.nix {
        pkgs = pkgs;
        version = "1.90.0.0"; # Rust version
        crosstool-version = "15.2.0_20250920"; # Cross-compiler toolchain version (GCC)
        binutils-version = "16.3_20250913"; # Binutils version (GDB)
    };
    
    # QEMU-ESPRESSIF
    esp-qemu-src = builtins.fetchTarball "https://gitlab.com/SFrijters/nix-qemu-espressif/-/archive/master/nix-qemu-espressif-master.tar.gz";
    esp-qemu = pkgs.callPackage "${esp-qemu-src}/packages/qemu-espressif" { enableTests = false; enableTools = true; };
in
pkgs.mkShell rec {
    name = "test-esp-rs-nix";

    buildInputs = [
        esp-rs 
        esp-qemu
        pkgs.espflash
        #pkgs.rustup 
        pkgs.pkg-config 
        pkgs.stdenv.cc 
        pkgs.libusb1
        pkgs.python3
        # Workspace command runners
        pkgs.just
        pkgs.mprocs
        # This is for parameterising the justfile
        pkgs.toml-cli
        pkgs.moreutils
        pkgs.gdb
    ];

    LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}";
}
