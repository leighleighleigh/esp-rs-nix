{
  pkgs,
  target, # xtensa or riscv32
  version,
}:
let
  # Fetch the url and hash
  src-url = (import ./urls.nix).esp-gcc { system = pkgs.stdenv.hostPlatform.system; targetarch = target; version = version; };
  src-hash = (builtins.fromJSON (builtins.readFile ./hashes.json)).${src-url};
in
pkgs.stdenv.mkDerivation {
  name = "esp-${target}-gcc";
  version = "${version}";
  src = pkgs.fetchzip {
    url = src-url;
    hash = src-hash;
  };

  dontStrip = pkgs.stdenv.hostPlatform.isDarwin;

  nativeBuildInputs =
    with pkgs;
    [
      gcc
      stdenv.cc.cc
      pkg-config
    ]
    ++ (if pkgs.stdenv.hostPlatform.isLinux then [ autoPatchelfHook ] else [ ]);

  outputs = [ "out" ];

  installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
  '';
}
