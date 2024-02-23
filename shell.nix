{ pkgs ? import <nixpkgs> {}}:
let 
    esp-rs = pkgs.callPackage ./esp-rs/default.nix {};
in
pkgs.mkShell rec {
    name = "esp-rs-nix";

    buildInputs = [ esp-rs pkgs.rustup pkgs.espflash ];

    shellHook = ''
    export PS1="(esp-rs)$PS1"
    # this is important - it tells rustup where to find the esp toolchain,
    # without needing to copy it into your local ~/.rustup/ folder.
    export RUSTUP_TOOLCHAIN=${esp-rs}
    '';
}
