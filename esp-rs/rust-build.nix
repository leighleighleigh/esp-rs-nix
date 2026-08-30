{
  pkgs,
  version,
}:
let
  # Fetch the url and hash
  src-url = (import ./urls.nix).rust-build { system = pkgs.stdenv.hostPlatform.system; version = version; };
  src-hash = (builtins.fromJSON (builtins.readFile ./hashes.json)).${src-url};

  install-cmd =
    if pkgs.stdenv.hostPlatform.isLinux then
      ''./install.sh --destdir=$out --prefix="" --disable-ldconfig --without=rust-docs-json-preview,rust-docs''
    else
      ''./install.sh --destdir=$out --prefix="" --without=rust-docs-json-preview,rust-docs'';
in
pkgs.stdenv.mkDerivation {
  name = "esp-rust-build";
  version = "${version}";
  src = pkgs.fetchzip {
    url = src-url;
    hash = src-hash;
  };

  dontStrip = pkgs.stdenv.hostPlatform.isDarwin;

  patchPhase = ''
    patchShebangs ./install.sh
  '';

  nativeBuildInputs =
    with pkgs;
    [
      pkg-config
      stdenv.cc.cc
      zlib
      gcc
    ]
    ++ (if pkgs.stdenv.hostPlatform.isLinux then [ autoPatchelfHook ] else [ ]);

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
    ${install-cmd}
  '';
}
