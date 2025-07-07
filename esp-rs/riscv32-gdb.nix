{
  pkgs ? import <nixpkgs> {},
  archname ? "x86_64-linux-gnu"
}:
let
in
pkgs.stdenv.mkDerivation rec {
    name = "esp-riscv32-gdb";
    version = "16.2_20250324";

    src = pkgs.fetchzip {
            url = "https://github.com/espressif/binutils-gdb/releases/download/esp-gdb-v${version}/riscv32-esp-elf-gdb-${version}-${archname}.tar.gz";
            hash = "sha256-uDro2vSq1HELT2n9mNhD+H5Ld1EBMfyGf3i+RGbPRjc=";
          };

    outputs = [ "out" ];

    installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    '';
}
