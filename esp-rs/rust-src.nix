{
  pkgs,
  esp-rust-build,
  esp-xtensa-gcc,
  esp-xtensa-gdb,
  esp-riscv32-gcc,
  esp-riscv32-gdb,
  version, #? "1.89.0.0",
}:
let 
  # Import our versions table
  srcList = (import ./versions.nix).rust-src;
  # Fetch the url and hash
  src-url = srcList.urlBuilder version;
  src-hash = srcList.${version};
in
pkgs.stdenv.mkDerivation {
  name = "esp-rust-src";
  version = "${version}";
  src = pkgs.fetchzip { url = src-url; hash = src-hash; };

  nativeBuildInputs = with pkgs; [
    # autoPatchelfHook
    # zlib
    # pkg-config
    # gcc
    # stdenv.cc.cc
  ];

  buildInputs = [
    esp-rust-build
    esp-xtensa-gcc
    esp-xtensa-gdb
    esp-riscv32-gcc
    esp-riscv32-gdb
  ];

  patchPhase = ''
  patchShebangs ./install.sh
  '';

  outputs = [ "out" ];

  installPhase = ''
  mkdir -p $out

  # copy esp-rust into output of this derivation, required for installation.
  cp -r ${esp-rust-build}/* $out
  chmod -R u+rw $out
  cp -r ${esp-xtensa-gcc}/* $out
  chmod -R u+rw $out
  cp -r ${esp-xtensa-gdb}/* $out
  chmod -R u+rw $out
  cp -r ${esp-riscv32-gcc}/* $out
  chmod -R u+rw $out
  cp -r ${esp-riscv32-gdb}/* $out
  chmod -R u+rw $out

  # install onto it
  ./install.sh --destdir=$out --prefix="" --disable-ldconfig

  runHook postInstall
  '';
}
