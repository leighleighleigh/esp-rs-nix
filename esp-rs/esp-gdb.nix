{
  pkgs,
  target, # xtensa or riscv32
  version,
}:
let
  # Fetch the url and hash
  src-url = (import ./urls.nix).esp-gdb { system = pkgs.stdenv.hostPlatform.system; targetarch = target; version = version; };
  src-hash = (builtins.fromJSON (builtins.readFile ./hashes.json)).${src-url};
in

pkgs.stdenv.mkDerivation {
  name = "esp-${target}-gdb";
  version = "${version}";
  src = pkgs.fetchzip {
    url = src-url;
    hash = src-hash;
  };
  dontStrip = pkgs.stdenv.hostPlatform.isDarwin;

  buildInputs = [
    # Required for GDB tooling
    pkgs.python3
  ];

  nativeBuildInputs =
    with pkgs;
    (if pkgs.stdenv.hostPlatform.isLinux then [ autoPatchelfHook ] else [ ]);

  # Because we might not have all required python versions available
  autoPatchelfIgnoreMissingDeps = [
    "libpython3.*.so.1.0"
  ];

  outputs = [ "out" ];

  installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
  '';
}
