{
  pkgs ? import <nixpkgs> {},
  archname ? "x86_64-linux-gnu",
}:
let
in
pkgs.stdenv.mkDerivation rec {
    name = "esp-xtensa-gcc";
    version = "13.2.0_20240530";

    src = pkgs.fetchzip {
            url = "https://github.com/espressif/crosstool-NG/releases/download/esp-${version}/xtensa-esp-elf-${version}-${archname}.tar.xz";
            sha256 = "sha256-Uv/3xzM9nQ7S2an90ubGN4BexJCr2RSQlAbmTfsNDdc=";
          };

    outputs = [ "out" ];

    installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    '';
}
