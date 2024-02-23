{ pkgs ? import <nixpkgs> {}}:
let
    esp-rust-build = pkgs.callPackage ./rust.nix {};
    esp-xtensa-gcc = pkgs.callPackage ./xtensa-gcc.nix {};
in
# this package is actually the 'rust-src' part of the esp-rs release - it's installed last, over the top
# of the esp-rs and xtensa-gcc files.
pkgs.stdenv.mkDerivation rec {
    name = "esp-rs";
    version = "1.76.0.1";

    buildInputs = [ esp-rust-build esp-xtensa-gcc ];

    src = pkgs.fetchzip {
            url = "https://github.com/esp-rs/rust-build/releases/download/v${version}/rust-src-${version}.tar.xz";
            sha256 = "sha256-fjevxpm7NT81QGpTBfM5COXLmRv59sA8wAiV0w/TduE=";
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

    # install onto it!
    ./install.sh --destdir=$out --prefix="" --disable-ldconfig
    '';
}
