{
  pkgs ? import <nixpkgs> {},
  archname ? "x86_64-linux-gnu",
}:
let
in
pkgs.stdenv.mkDerivation rec {
    name = "esp-xtensa-gcc";
    version = "14.2.0_20240906";

    src = pkgs.fetchzip {
            url = "https://github.com/espressif/crosstool-NG/releases/download/esp-${version}/xtensa-esp-elf-${version}-${archname}.tar.xz";
            hash = "sha256-uZ8md2PJQhIsJAHO7hK9+Hn8mPI/erhFpW22w/fS3+g=";
          };

    outputs = [ "out" ];

    installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    '';
}
