{
  pkgs ? import <nixpkgs> {},
  archname ? "x86_64-linux-gnu"
}:
let
in
pkgs.stdenv.mkDerivation rec {
    name = "esp-xtensa-gdb";
    version = "16.2_20250324";

    src = pkgs.fetchzip {
            url = "https://github.com/espressif/binutils-gdb/releases/download/esp-gdb-v${version}/xtensa-esp-elf-gdb-${version}-${archname}.tar.gz";
            hash = "sha256-gphR1KiiPKxlZ0cQKskiMQj3hkbiW7pwhHoF38cbBC0=";
          };

    outputs = [ "out" ];

    installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    '';
}
