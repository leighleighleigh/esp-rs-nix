{ pkgs ? import <nixpkgs> {}}:
let 
    # source version
    esp-rs = pkgs.callPackage ../esp-rs/default.nix {};
    # QEMU-ESPRESSIF
    esp-qemu-src = builtins.fetchTarball "https://github.com/leighleighleigh/nix-qemu-espressif/archive/master.tar.gz";
    #esp-qemu-src = builtins.fetchTarball "https://gitlab.com/SFrijters/nix-qemu-espressif/-/archive/master/nix-qemu-espressif-master.tar.gz";
    esp-qemu = pkgs.callPackage "${esp-qemu-src}/packages/qemu-espressif" { enableTests = false; enableTools = true; };
in
pkgs.mkShell rec {
    name = "test-esp-rs-nix";

    buildInputs = [
        esp-rs 
        esp-qemu
        pkgs.rustup 
        pkgs.espflash
        #pkgs.rust-analyzer
        pkgs.pkg-config 
        pkgs.stdenv.cc 
        #pkgs.bacon 
        pkgs.systemdMinimal
        #pkgs.lunarvim 
        #pkgs.inotify-tools
        #pkgs.picocom
        #pkgs.vscode-fhs
        pkgs.libusb1
        pkgs.python3Full

        # Workspace command runners
        pkgs.just
        pkgs.mprocs
        # This is for parameterising the justfile
        pkgs.toml-cli
        pkgs.moreutils
        pkgs.gdb
    ];

    LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}";

    shellHook = ''
    # custom bashrc stuff
    export PS1_PREFIX="(esp-rs)"
    . ~/.bashrc

    export LD_LIBRARY_PATH="''${LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}"
    # this is important - it tells rustup where to find the esp toolchain,
    # without needing to copy it into your local ~/.rustup/ folder.
    export RUSTUP_TOOLCHAIN=${esp-rs}

    # Load shell completions for espflash
    if (which espflash >/dev/null 2>&1); then
    . <(espflash completions $(basename $SHELL))
    fi
    '';
}
