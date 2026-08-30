{
  # Top-level list of supported versions.
  # These are used to pre-fetch source file hashes, stored in hashes.json.
  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];

  targets = [
    "xtensa"
    "riscv32"
  ];

  rustc_versions = [
    "1.98.0.0"
    "1.97.0.0"
    "1.96.0.0"
    "1.95.0.0"
    "1.94.0.2"
    "1.94.0.1"
    "1.94.0.0"
    "1.93.0.0"
    "1.92.0.0"
    "1.91.1.0"
    "1.90.0.0"
    "1.89.0.0"
    "1.88.0.0"
    "1.87.0.0"
    "1.86.0.0"
  ];

  crosstool_versions = [
    "16.1.0_20260609"
    "15.2.0_20251204"
    "15.2.0_20250920"
    "15.1.0_20250607"
  ];

  binutils_versions = [
    "17.1_20260402"
    "16.3_20250913"
    "16.2_20250324"
  ];
}