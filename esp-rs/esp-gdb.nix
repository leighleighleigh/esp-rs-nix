{
  pkgs,
  binutils-version, 
  systemName, #? "x86_64-linux",
  targetName, #? xtensa or riscv32
}:
let 
  # Import our versions table
  srcList = (import ./versions.nix).esp-gdb;
  # Figure out our archmame
  archName = srcList.systemNameMap.${systemName};
  # Fetch the url and hash
  src-url = srcList.urlBuilder archName targetName binutils-version;
  src-hash = srcList.${binutils-version}.${targetName}.${archName};
in
pkgs.stdenv.mkDerivation {
  name = "esp-${targetName}-gdb";
  version = "${binutils-version}";
  src = pkgs.fetchzip { url = src-url; hash = src-hash; };

  outputs = [ "out" ];

  installPhase = ''
  mkdir -p $out
  cp -r ./* $out/
  '';
}
