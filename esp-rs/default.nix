# THIS FILE IS ONLY HERE TO PROVIDE BACKWARDS-COMPATIBILITY
# WITH THE PRE-FLAKE-PARTS VERSIONS OF THIS REPO.
{
  pkgs ? import <nixpkgs> {}, 
  # Rust version
  version ? "1.89.0.0",
  # Cross-compiler toolchain version (GCC)
  crosstool-version ? "15.1.0_20250607",
  # Binutils version (GDB)
  binutils-version ? "16.2_20250324",
}:
let 
  # Get our system string
  systemName = pkgs.stdenv.hostPlatform.system;

  esp-rust-build = pkgs.callPackage ./rust-build.nix { version = version; systemName = systemName; };
  esp-xtensa-gcc = pkgs.callPackage ./esp-gcc.nix { crosstool-version = crosstool-version; systemName = systemName; targetName = "xtensa"; };
  esp-xtensa-gdb = pkgs.callPackage ./esp-gdb.nix { binutils-version = binutils-version; systemName = systemName; targetName = "xtensa"; };
  esp-riscv32-gcc = pkgs.callPackage ./esp-gcc.nix { crosstool-version = crosstool-version; systemName = systemName; targetName = "riscv32"; };
  esp-riscv32-gdb = pkgs.callPackage ./esp-gdb.nix { binutils-version = binutils-version; systemName = systemName; targetName = "riscv32"; };
in
# rust-src is the last thing to be built, as it depends on the other packages
pkgs.callPackage ./rust-src.nix {
  version = version;
  esp-rust-build = esp-rust-build;
  esp-xtensa-gcc = esp-xtensa-gcc;
  esp-xtensa-gdb = esp-xtensa-gdb;
  esp-riscv32-gcc = esp-riscv32-gcc;
  esp-riscv32-gdb = esp-riscv32-gdb;
}
