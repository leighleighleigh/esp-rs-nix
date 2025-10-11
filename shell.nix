{ 
  perSystem = { pkgs, self', ... }: {
    devShells.default = pkgs.mkShell {
      packages = [
        self'.packages.esp-rs
        pkgs.rust-analyzer
        pkgs.rustup
        pkgs.espflash
        pkgs.pkg-config
        pkgs.stdenv.cc
        pkgs.systemdMinimal
      ];

      shellHook = ''
        # Add a prefix 'esp-rs' to the shell prompt
        export PS1="(esp-rs)$PS1"

        # This variable is important - it tells rustup where to find the esp toolchain,
        # without needing to copy it into your local ~/.rustup/ folder.
        export RUSTUP_TOOLCHAIN=${self'.packages.esp-rs}
      '';
    };
  };
}
