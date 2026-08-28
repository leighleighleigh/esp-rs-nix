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

A specific version of the rust toolchain can selected, by changing the `version`, `crosstool-version`, and `binutils-version` variables.  

Below is a table of the currently supported versions, **with the defaults bolded**.  
I will update the defaults periodically, to maintain compatibility with the `main` branch of [esp-hal](https://github.com/esp-rs/esp-hal).

<table>
<tr></tr>
<tr><td valign="top">

| rust-build (rustc) |
| :----------------: |
|     1.98.0.0^      |
|      1.97.0.0      |
|    **1.96.0.0**    |
|      1.95.0.0      |
|      1.94.0.2      |
|      1.94.0.1      |
|      1.94.0.0      |
|      1.93.0.0      |
|      1.92.0.0      |
|      1.91.1.0      |
|      1.90.0.0      |
|      1.89.0.0      |
|      1.88.0.0      |
|      1.87.0.0      |
|      1.86.0.0      |

^Not yet available for macOS

</td><td valign="top">
 
| crosstool-NG (gcc) |
| :----------------: |
|  **16.1.0_20260609**   |
|  15.2.0_20251204   |
|  15.2.0_20250920   |
|  15.1.0_20250607   |

</td><td valign="top">

| binutils (gdb) |
| :------------: |
| **17.1_20260402**  |
| 16.3_20250913  |
| 16.2_20250324  |


</td></tr></table>
 
New versions can be added by updating the `./esp-rs/versions.nix` file with additional file hashes.  
The scripts found in the `utils/` folder, may be edited to prefetch and calculate these.  
