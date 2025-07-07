{
  pkgs ? import <nixpkgs> {},
  archname ? "x86_64-linux-gnu",
}:
let
    esp-rust-build = pkgs.callPackage ./rust.nix {};
    esp-xtensa-gcc = pkgs.callPackage ./xtensa-gcc.nix {};
    esp-riscv32-gcc = pkgs.callPackage ./riscv32-gcc.nix {};
    esp-riscv32-gdb = pkgs.callPackage ./riscv32-gdb.nix {};
in
# this package is actually the 'rust-src' part of the esp-rs release - it's installed last, over the top
# of the esp-rs and xtensa-gcc files.
pkgs.stdenv.mkDerivation rec {
    name = "esp-rs";
    version = "1.88.0.0";

    nativeBuildInputs = with pkgs; [ autoPatchelfHook zlib pkg-config gcc stdenv.cc.cc ];
    buildInputs = [ esp-rust-build esp-xtensa-gcc esp-riscv32-gcc ];
    autoPatchelfIgnoreMissingDeps = [ "*" ];
    
    # The rust-src component from espressif rustc
    src = pkgs.fetchzip {
            url = "https://github.com/esp-rs/rust-build/releases/download/v${version}/rust-src-${version}.tar.xz";
            hash = "sha256-zWuLI2+q0rO9ANFZOEwLHbvaO+ZANI/MJpj/JBrhxiQ=";
          };

    patchPhase = '' 
    patchShebangs ./install.sh
    '';

    outputs = [ "out" ];

    installPhase = ''
    mkdir -p $out

    # copy across all of esp-rust into our own output 
    cp -r ${esp-rust-build}/* $out
    chmod -R u+rw $out
    cp -r ${esp-xtensa-gcc}/* $out
    chmod -R u+rw $out
    cp -r ${esp-riscv32-gcc}/* $out
    chmod -R u+rw $out
    cp -r ${esp-riscv32-gdb}/* $out
    chmod -R u+rw $out

    # install onto it!
    ./install.sh --destdir=$out --prefix="" --disable-ldconfig

    runHook postInstall
    '';
}
