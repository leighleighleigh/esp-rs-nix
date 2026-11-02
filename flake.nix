{
  description = "A nix-shell for developing with Rust on Xtensa+RISCV ESP32 targets";

  inputs = {
    nixpkgs = {
      type = "indirect";
      id = "nixpkgs";
    };

    ## Out-of-repo flake.nix usage - use this for your own flake.nix files!
    #esp-rs-src = {
    #  url = "github:leighleighleigh/esp-rs-nix?branch=main";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    # In-repo flake.nix usage, used in CI.
    esp-rs-src = {
      url = "path:./";
      flake = false; # Prevent circular imports
    };
  };

  outputs = inputs: {
    # Build these with `nix build ...`
    packages = builtins.mapAttrs (system: pkgs: {
      esp-rs = pkgs.callPackage "${inputs.esp-rs-src}/package.nix" { };
      default = inputs.self.packages.${system}.esp-rs;
    }) inputs.nixpkgs.legacyPackages;

    # Instantiate the default dev shell with `nix develop`
    devShells = builtins.mapAttrs (system: pkgs: {
      default =
        let
          # esp-rs-nix/package.nix contains the compiler toolchain, and is built above.
          # The toolchain versions may be overidden, if desired.
          esp-rs = inputs.self.packages.${system}.esp-rs.override {
            # (Optional) Override the default rustc version
            #rustc-version = "1.95.0.0";
            # (Optional) Override the default cross-compiler (GCC) toolchain version
            #crosstool-version = "16.1.0_20260609";
            # (Optional) Override the default binutils (GDB) version
            #binutils-version = "17.1_20260402";
          };

        in
        pkgs.mkShell rec {
          name = "esp-rs-nix";

          packages = [
            esp-rs
          ]
          ++ [
            # You may wish to change these remaining packages,
            # depending on your application.
            pkgs.rust-analyzer
            pkgs.rustup
            pkgs.espflash
            pkgs.pkg-config
            pkgs.stdenv.cc
          ];

          shellHook = ''
            # Add a prefix to the shell prompt
            export PS1="(${name})$PS1"
            # This variable is important - it tells rustup where to find the esp toolchain,
            # without needing to copy it into your local ~/.rustup/ folder.
            export RUSTUP_TOOLCHAIN=${esp-rs}
          '';
        };
    }) inputs.nixpkgs.legacyPackages;
  };
}
