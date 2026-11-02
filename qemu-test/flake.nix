{
  description = "qemu-test crate for esp-rs-nix";

  inputs = {
    nixpkgs = {
      type = "indirect";
      id = "nixpkgs";
    };
    
    ## Upstream, out-of-repo usage - use this, in your own flake.nix files!
    #esp-rs = {
    #  url = "github:leighleighleigh/esp-rs-nix?brach=main";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    # Local, in-repo usage.
    esp-rs = {
      url = "path:../";
    };

    qemu-espressif = {
      url = "git+https://gitlab.com/SFrijters/nix-qemu-espressif";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    # Instantiate the default dev shell with `nix develop`
    devShells = builtins.mapAttrs (system: pkgs: {
      default = let
        esp-rs = inputs.esp-rs.packages.${system}.default;
        esp-qemu = inputs.qemu-espressif.packages.${system}.default.override {
          enableTests = false;
          enableTools = true;
        };
      in pkgs.mkShell rec {
        name = "qemu-test-esp-rs-nix";

        packages = [ esp-rs esp-qemu ] ++ [
          # You may wish to change these remaining packages, 
          # depending on your application.
          pkgs.rust-analyzer
          pkgs.rustup
          pkgs.espflash
          pkgs.pkg-config
          pkgs.stdenv.cc
          pkgs.rustup
          pkgs.espflash
          pkgs.pkg-config
          pkgs.stdenv.cc
          pkgs.libusb1
          pkgs.python3
          # Workspace command runners
          pkgs.just
          pkgs.mprocs
          # This is for parameterising the justfile
          pkgs.toml-cli
          pkgs.moreutils
          pkgs.gdb
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
