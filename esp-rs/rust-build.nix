{
  pkgs,
  version, #? "1.89.0.0",
  systemName,#? "x86_64-linux",
}:
let 
  # Import our versions table
  srcList = (import ./versions.nix).rust-build;
  # Figure out our archmame
  archName = srcList.systemNameMap.${systemName};
  # Fetch the url and hash
  src-url = srcList.urlBuilder archName version;
  src-hash = srcList.${version}.${archName};
in
pkgs.stdenv.mkDerivation {
  name = "esp-rust-build";
  version = "${version}";
  src = pkgs.fetchzip { url = src-url; hash = src-hash; };

  patchPhase = ''
    patchShebangs ./install.sh
  '';

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    pkg-config
    stdenv.cc.cc
    zlib
    gcc
  ];

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