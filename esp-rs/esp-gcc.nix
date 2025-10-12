{
  pkgs,
  crosstool-version, #? "15.1.0_20250607",
  systemName, #? "x86_64-linux",
  targetName, #? xtensa or riscv32
}:
let 
  # Import our versions table
  srcList = (import ./versions.nix).esp-gcc;
  # Figure out our archmame
  archName = srcList.systemNameMap.${systemName};
  # Fetch the url and hash
  src-url = srcList.urlBuilder archName targetName crosstool-version;
  src-hash = srcList.${crosstool-version}.${targetName}.${archName};
in
pkgs.stdenv.mkDerivation {
  name = "esp-${targetName}-gcc";
  version = "${crosstool-version}";
  src = pkgs.fetchzip { url = src-url; hash = src-hash; };

  outputs = [ "out" ];

  installPhase = ''
  mkdir -p $out
  cp -r ./* $out/
  '';
}
