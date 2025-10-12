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
        ./shell.nix
      ];
    };
}
