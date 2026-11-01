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
      default = pkgs.callPackage ./shell.nix { };
    }) inputs.nixpkgs.legacyPackages;
  };
}
