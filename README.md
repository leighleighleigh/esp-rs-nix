# esp-rs-nix 

Project goals:
 - [x] Take this: https://github.com/esp-rs/rust-build ...
 - [x] ...and this: https://github.com/espressif/crosstool-NG,
 - [x] ...and this: https://github.com/espressif/binutils-gdb,
 - [x] ...and mangle them into a nix derivation (using hard-coded pre-built binaries for now).
 - [x] Then, take this: https://github.com/esp-rs/esp-hal ...
 - [x] ... run `nix-shell`, and compile blinky for esp32s3. 

Project status: **works on my machine!**

> [!TIP]
> Now supports `x86_64-linux`,`aarch64-linux`, and `aarch64-darwin` hosts!

# Getting Started 

For `nix-shell` use, please refer to `shell.nix`.  
For `nix develop` use, please refer to `flake.nix` and `package.nix`.

# Why?

The recommended installation method using the `espup` tool didn't work for me.

# Notes

 - This is for development of `no_std`, `esp-hal`-based applications only. NOT for use with `esp-hal-idf`.
 - ~~This is hard-coded to download binaries for `x86_64` only, at the moment.~~
 - PRs welcome!

# Toolchain version support

A specific version of the rust toolchain can selected, using the `rustc-version`, `crosstool-version`, and `binutils-version` variables defined in `package.nix`. Below is a table of the currently supported versions, **with the defaults bolded**. I will update these defaults periodically, to maintain compatibility with the `main` branch of [esp-hal](https://github.com/esp-rs/esp-hal).

> [!TIP] To add support for a new toolchain version, perform the following steps:
> 1. Add the new version numbers to `utils/versions.nix`
> 2. Run the `utils/update-hashes.sh` script, which will update `esp-rs/hashes.json` with the release artifact file hashes
> 3. Commit and push the changed files


| Release Date | rust-build (rustc) |   crosstool-NG (gcc)    |       binutils (gdb)        |
| :----------: | :----------------: | :---------------------: | :-------------------------: |
|  2026-08-20  |     v1.98.0.0      |                         |                             |
|  2026-07-08  |     v1.97.0.0      |                         |                             |
|  2026-06-09  |                    | **esp-16.1.0_20260609** |                             |
|  2026-05-27  |   **v1.96.0.0**    |                         |                             |
|  2026-04-15  |     v1.95.0.0      |                         |                             |
|  2026-04-02  |                    |                         | **esp-gdb-v17.1_20260402**  |
|  2026-03-16  |     v1.94.0.2      |                         |                             |
|  2026-03-13  |     v1.94.0.1      |                         |                             |
|  2026-03-03  |     v1.94.0.0      |                         |                             |
|  2026-02-03  |                    |   esp-13.2.0_20260203   |                             |
|  2026-01-26  |                    |   esp-14.2.0_20260121   |                             |
|  2026-01-20  |     v1.93.0.0      |                         |                             |
|  2025-12-19  |                    |   esp-14.2.0_20251219   |                             |
|  2025-12-11  |     v1.92.0.0      |                         |                             |
|  2025-12-10  |                    |   esp-14.2.0_20251208   |                             |
|  2025-12-05  |                    |   esp-15.2.0_20251204   |                             |
|  2025-12-01  |                    |   esp-15.2.0_20251201   |                             |
|  2025-11-26  |                    |   esp-15.2.0_20251127   |                             |
|  2025-11-17  |     v1.91.1.0      |                         |                             |
|  2025-11-07  |                    |   esp-14.2.0_20251107   |                             |
|  2025-11-04  |                    |   esp-14.2.0_20251103   |                             |
|  2025-10-23  |                    |   esp-14.2.0_20251024   |                             |
|  2025-09-28  |                    |   esp-15.2.0_20250929   |                             |
|  2025-09-20  |                    |   esp-15.2.0_20250920   |                             |
|  2025-09-16  |     v1.90.0.0      |                         |                             |
|  2025-09-13  |                    |                         |   esp-gdb-v16.3_20250913    |
|  2025-09-10  |                    |   esp-12.2.0_20250801   |                             |
|  2025-08-20  |     v1.89.0.0      |                         |                             |
|  2025-07-30  |                    |   esp-14.2.0_20250730   |                             |
|  2025-07-07  |                    |   esp-13.2.0_20250707   |                             |
|  2025-06-24  |     v1.88.0.0      |                         |                             |
|  2025-06-07  |                    |   esp-15.1.0_20250607   |                             |
|  2025-05-27  |     v1.87.0.0      |                         |                             |
|  2025-04-01  |     v1.86.0.0      |                         |                             |
|  2025-03-24  |                    |                         |   esp-gdb-v16.2_20250324    |
|  2025-02-18  |     v1.85.0.0      |                         |                             |
|  2025-01-10  |     v1.84.0.0      |                         |                             |
|  2024-12-09  |     v1.83.0.1      |                         |                             |
|  2024-11-26  |     v1.83.0.0      |                         |                             |
|  2024-11-20  |                    |   esp-14.2.0_20241119   |                             |
|  2024-11-12  |                    |                         |   esp-gdb-v15.2_20241112    |
|  2024-10-30  |     v1.82.0.3      |                         |                             |
|  2024-10-28  |     v1.82.0.2      |                         |                             |
|  2024-10-25  |     v1.82.0.1      |                         |                             |
|  2024-10-21  |     v1.82.0.0      |                         |                             |
|  2024-09-06  |                    |   esp-14.2.0_20240906   |                             |
|  2024-09-03  |     v1.81.0.0      |                         |                             |
|  2024-07-22  |     v1.80.0.0      |                         |                             |
|  2024-06-11  |     v1.79.0.0      |                         |                             |
|  2024-05-30  |                    |   esp-13.2.0_20240530   |                             |
|  2024-05-01  |     v1.78.0.0      |                         |                             |
|  2024-04-03  |                    |                         |   esp-gdb-v14.2_20240403    |
|  2024-03-19  |     v1.77.0.0      |                         |                             |
|  2024-03-06  |                    |   esp-13.2.0_20240305   |                             |
|  2024-02-12  |     v1.76.0.1      |                         |                             |
|  2024-02-05  |     v1.76.0.0      |                         |                             |
|  2023-10-23  |                    |                         |   esp-gdb-v12.1_20231023    |
|  2023-09-28  |                    |   esp-13.2.0_20230928   |                             |

