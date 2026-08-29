{
  description = "A nix-shell for developing with Rust on Xtensa+RISCV ESP32 targets";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs: {
    # Build these with `nix build ...`
    packages = builtins.mapAttrs (system: pkgs: {
      esp-rs = pkgs.callPackage ./package.nix { };
      default = inputs.self.packages.${system}.esp-rs;
    }) inputs.nixpkgs.legacyPackages;

    # Instantiate the default dev shell with `nix develop`
    devShells = builtins.mapAttrs (system: pkgs: {
      default = pkgs.mkShell {
        packages = [
          pkgs.stdenv.cc
          pkgs.pkg-config
          pkgs.rustup
          pkgs.rust-analyzer
          pkgs.espflash
        ];

        shellHook = ''
          # (OPTIONAL) Add a prefix 'esp-rs' to the shell prompt
          export PS1="(esp-rs-devshell)$PS1"
          # This variable is important - it tells rustup where to find the esp toolchain,
          # without needing to copy it into your local ~/.rustup/ folder.
          export RUSTUP_TOOLCHAIN=${inputs.self.packages.${system}.esp-rs}
        '';
      };
    }) inputs.nixpkgs.legacyPackages;
  };
}
