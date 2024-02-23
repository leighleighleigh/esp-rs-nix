{ pkgs ? import <nixpkgs> {}}:
let
in
pkgs.stdenv.mkDerivation rec {
    name = "esp-rust-build";
    version = "1.76.0.1";

    src = pkgs.fetchzip {
            url = "https://github.com/esp-rs/rust-build/releases/download/v${version}/rust-${version}-x86_64-unknown-linux-gnu.tar.xz";
            sha256 = "sha256-HoBlsE4GE9bK1naAZ3BeG/LrB25QyLM3eEkMibS8tuw=";
          };

    patchPhase = '' 
    patchShebangs ./install.sh
    '';

    outputs = [ "out" ];

    #Usage: ./install.sh [options]
    #Options:

    #    --uninstall                      only uninstall from the installation prefix
    #    --destdir=[<none>]               set installation root
    #    --prefix=[/usr/local]            set installation prefix
    #    --without=[<none>]               comma-separated list of components to not install
    #    --components=[<none>]            comma-separated list of components to install
    #    --list-components                list available components
    #    --sysconfdir=[/etc]              install system configuration files
    #    --bindir=[/bin]                  install binaries
    #    --libdir=[/lib]                  install libraries
    #    --datadir=[/share]               install data
    #    --mandir=[/share/man]            install man pages in PATH
    #    --docdir=[\<default\>]           install documentation in PATH
    #    --disable-ldconfig               don't run ldconfig after installation (Linux only)
    #    --disable-verify                 don't obsolete
    #    --verbose                        run with verbose output

    installPhase = ''
    mkdir -p $out
    ./install.sh --destdir=$out --prefix="" --disable-ldconfig --without=rust-docs-json-preview,rust-docs
    '';
}
