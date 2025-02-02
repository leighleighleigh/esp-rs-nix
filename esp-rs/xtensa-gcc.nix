{
  pkgs ? import <nixpkgs> {},
  archname ? "x86_64-linux-gnu",
}:
let
in
pkgs.stdenv.mkDerivation rec {
    name = "esp-xtensa-gcc";
    version = "14.2.0_20241119";

    src = pkgs.fetchzip {
            url = "https://github.com/espressif/crosstool-NG/releases/download/esp-${version}/xtensa-esp-elf-${version}-${archname}.tar.xz";
            hash = "sha256-pX2KCnUoGZtgqFmZEuNRJxDMQgqYYPRpswL3f3T0nWE=";
          };

    outputs = [ "out" ];

    installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    '';
}
