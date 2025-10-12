{
  pkgs,
  version ? "1.89.0.0",
  systemName ? "x86_64-linux",
}:
let 
  # Other packages we depend on
  esp-rust-build = pkgs.callPackage ./rust-build.nix { version = version; systemName = systemName; };

  srcList = (import ./versions.nix).rust-src;
  src-url = srcList.urlBuilder version;
  src-hash = srcList.${version};
in
pkgs.stdenv.mkDerivation {
  name = "esp-rs";
  version = "${version}";
  src = pkgs.fetchzip { url = src-url; hash = src-hash; };

  patchPhase = ''
  patchShebangs ./install.sh
  '';

  outputs = [ "out" ];

  installPhase = ''
  mkdir -p $out

  # copy esp-rust into output of this derivation, required for installation.
  cp -r ${esp-rust-build}/* $out
  chmod -R u+rw $out

  # install onto it
  ./install.sh --destdir=$out --prefix="" --disable-ldconfig

  runHook postInstall
  '';
}