{
  pkgs ? import <nixpkgs> {},
  archname ? "x86_64-linux-gnu"
}:
let
in
pkgs.stdenv.mkDerivation rec {
    name = "esp-riscv32-gcc";
    version = "14.2.0_20240906";

    src = pkgs.fetchzip {
            url = "https://github.com/espressif/crosstool-NG/releases/download/esp-${version}/riscv32-esp-elf-${version}-${archname}.tar.xz";
            hash = "sha256-xSAtR0dnEW8xW/93eO4t9YgXREqo/R4PreXnalGQusM=";
          };

    outputs = [ "out" ];

    installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    '';
}
