{
  description = "A nix-shell for developing with Rust on Xtensa+RISCV ESP32 targets";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        shell = pkgs.callPackage ./shell.nix {};
      in {
        package = rec {
          inherit shell;
          default = shell;
        };
        devShells.default = shell;
      }
    );
}
