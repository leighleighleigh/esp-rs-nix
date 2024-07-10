{
  pkgs ? import <nixpkgs> {},
  archname ? "x86_64-linux-gnu"
}:
let
in
pkgs.stdenv.mkDerivation rec {
    name = "esp-riscv32-gcc";
    version = "13.2.0_20240530";

    src = pkgs.fetchzip {
            url = "https://github.com/espressif/crosstool-NG/releases/download/esp-${version}/riscv32-esp-elf-${version}-${archname}.tar.xz";
            sha256 = "sha256-/M+kqx5xtEHViMbK1l8Tt5XwsMBk/zCvqvzp8PawckQ=";
          };

    outputs = [ "out" ];

    installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    '';
}
