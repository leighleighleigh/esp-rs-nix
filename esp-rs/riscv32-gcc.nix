{
  pkgs ? import <nixpkgs> {},
  archname ? "x86_64-linux-gnu"
}:
let
in
pkgs.stdenv.mkDerivation rec {
    name = "esp-riscv32-gcc";
    version = "14.2.0_20241119";

    src = pkgs.fetchzip {
            url = "https://github.com/espressif/crosstool-NG/releases/download/esp-${version}/riscv32-esp-elf-${version}-${archname}.tar.xz";
            hash = "sha256-67O34FYUnVG2nfkfQj2yH874qDSYx4F/16xxPi0kNbY=";
          };

    outputs = [ "out" ];

    installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    '';
}
