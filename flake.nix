{
  description = "A nix-shell for developing with Rust on Xtensa+RISCV ESP32 targets";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; }
    {
      # List of supported systems
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      
      # Import the modular flake parts here
      imports = [
        ./package.nix
      ];

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
    };
}
