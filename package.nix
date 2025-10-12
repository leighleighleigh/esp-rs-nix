{
  debug = true;

  perSystem = { pkgs, self', system, ... }:
    let 
      # Rust version
      version = "1.89.0.0";
      # Cross-compiler toolchain version (GCC)
      crosstool-version = "15.1.0_20250607";
      # Binutils version (GDB)
      binutils-version = "16.2_20250324";
      # Get our system string
      systemName = pkgs.stdenv.hostPlatform.system;
      # systemName = "${system}";
      # systemName = "${pkgs.hostPlatform}";
    in
    {
      # Rustc version
      packages.esp-rust-build = pkgs.callPackage ./esp-rs/rust-build.nix { version = version; systemName = systemName; };

      packages.esp-xtensa-gcc = pkgs.callPackage ./esp-rs/esp-gcc.nix { crosstool-version = crosstool-version; systemName = systemName; targetName = "xtensa"; };
      packages.esp-xtensa-gdb = pkgs.callPackage ./esp-rs/esp-gdb.nix { binutils-version = binutils-version; systemName = systemName; targetName = "xtensa"; };

      packages.esp-riscv32-gcc = pkgs.callPackage ./esp-rs/esp-gcc.nix { crosstool-version = crosstool-version; systemName = systemName; targetName = "riscv32"; };
      packages.esp-riscv32-gdb = pkgs.callPackage ./esp-rs/esp-gdb.nix { binutils-version = binutils-version; systemName = systemName; targetName = "riscv32"; };

      # rust-src is the last thing to be built, as it depends on the other packages
      packages.esp-rs = pkgs.callPackage ./esp-rs/rust-src.nix {
        version = version;
        esp-rust-build = self'.packages.esp-rust-build;
        esp-xtensa-gcc = self'.packages.esp-xtensa-gcc;
        esp-xtensa-gdb = self'.packages.esp-xtensa-gdb;
        esp-riscv32-gcc = self'.packages.esp-riscv32-gcc;
        esp-riscv32-gdb = self'.packages.esp-riscv32-gdb;
      };

      packages.default = self'.packages.esp-rs;
    };
}
