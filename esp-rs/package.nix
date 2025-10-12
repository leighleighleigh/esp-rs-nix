{
  pkgs,
  version ? "1.89.0.0",
  crosstool-version ? "15.1.0_20250607",
  binutils-version ? "16.2_20250324",
  systemName ? "x86_64-linux",
}:
let 
  # rust-src is the last thing to be built, as it depends on the other packages
  esp-rust-build = pkgs.callPackage ./rust-build.nix { version = version; systemName = systemName; };
  esp-xtensa-gcc = pkgs.callPackage ./esp-gcc.nix { crosstool-version = crosstool-version; systemName = systemName; targetName = "xtensa"; };
  esp-riscv32-gcc = pkgs.callPackage ./esp-gcc.nix { crosstool-version = crosstool-version; systemName = systemName; targetName = "riscv32"; };

  esp-xtensa-gdb = pkgs.callPackage ./esp-gdb.nix { binutils-version = binutils-version; systemName = systemName; targetName = "xtensa"; };
  esp-riscv32-gdb = pkgs.callPackage ./esp-gdb.nix { binutils-version = binutils-version; systemName = systemName; targetName = "riscv32"; };

  esp-rust-src = pkgs.callPackage ./rust-src.nix { version = version; esp-rust-build = esp-rust-build; esp-xtensa-gcc = esp-xtensa-gcc; esp-riscv32-gcc = esp-riscv32-gcc; esp-xtensa-gdb = esp-xtensa-gdb; esp-riscv32-gdb = esp-riscv32-gdb; };
in
esp-rust-src