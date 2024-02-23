{ pkgs ? import <nixpkgs> {}}:
let
in
pkgs.stdenv.mkDerivation rec {
    name = "esp-xtensa-gcc";
    version = "13.2.0_20230928";

    src = pkgs.fetchzip {
            url = "https://github.com/espressif/crosstool-NG/releases/download/esp-${version}/xtensa-esp-elf-${version}-x86_64-linux-gnu.tar.xz";
            sha256 = "sha256-0Gc72RGzPvkI9tD/1gLlJ7PRVXsNQRQraiIKOqebD1o=";
          };

    outputs = [ "out" ];

    installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    '';
}
