{
  pkgs,
  rustc-version ? "1.96.0.0", # Default rustc version
  crosstool-version ? "16.1.0_20260609", # Default cross-compiler (GCC) toolchain version
  binutils-version ? "17.1_20260402", # Default binutils (GDB) version
  ...
}:
let
  esp-rust-build = pkgs.callPackage ./esp-rs/rust-build.nix {
    version = rustc-version;
  };
  esp-xtensa-gcc = pkgs.callPackage ./esp-rs/esp-gcc.nix {
    version = crosstool-version;
    target = "xtensa";
  };
  esp-xtensa-gdb = pkgs.callPackage ./esp-rs/esp-gdb.nix {
    version = binutils-version;
    target = "xtensa";
  };
  esp-riscv32-gcc = pkgs.callPackage ./esp-rs/esp-gcc.nix {
    version = crosstool-version;
    target = "riscv32";
  };
  esp-riscv32-gdb = pkgs.callPackage ./esp-rs/esp-gdb.nix {
    version = binutils-version;
    target = "riscv32";
  };
in
# rust-src is the last thing to be built, as it depends on the other packages
pkgs.callPackage ./esp-rs/rust-src.nix {
  version = rustc-version;
  esp-rust-build = esp-rust-build;
  esp-xtensa-gcc = esp-xtensa-gcc;
  esp-xtensa-gdb = esp-xtensa-gdb;
  esp-riscv32-gcc = esp-riscv32-gcc;
  esp-riscv32-gdb = esp-riscv32-gdb;
}
