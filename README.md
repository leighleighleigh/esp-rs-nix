# esp-rs-nix 

Project goals:
 - [x] Take this: https://github.com/esp-rs/rust-build ...
 - [x] ...and this: https://github.com/espressif/crosstool-NG,
 - [x] ...and mangle them into a nix derivation (using hard-coded pre-built binaries for now).
 - [x] Then, take this: https://github.com/esp-rs/esp-hal ...
 - [x] ... run `nix-shell`, and compile blinky for esp32s3. 

Project status: **works on my machine!**

> [!TIP]
> Now supports `x86_64-linux`,`aarch64-linux`, and `aarch64-apple-darwin` systems!

# Getting started 

For `nix-shell` use, please refer to `shell.nix`.  
For `nix develop` use, please refer to `flake.nix` and `package.nix`.

# Version selection

A specific version of the rust toolchain can used with either the `shell.nix`, or `package.nix` files.  
Below is a table of the currently supported versions.  

| rust-build (rustc) | crosstool-NG (gcc) | binutils (gdb) |
| :----------------: | :----------------: | :------------: |
| 1.90.0.0           | 15.2.0_20250920    | 16.3_20250913  |
| 1.89.0.0           | 15.1.0_20250607    | 16.2_20250324  |
| 1.88.0.0           |                    |                |
| 1.87.0.0           |                    |                |
| 1.86.0.0           |                    |                |

New versions can be added by updating the `./esp-rs/versions.nix` file with the correct file hashes.  

# why?

The recommended installation method using the `espup` tool didn't work for me.

# notes

 - This is for development of `no_std`, `esp-hal`-based applications only. NOT for use with `esp-hal-idf`.
 - ~~This is hard-coded to download binaries for `x86_64` only, at the moment.~~
 - PRs welcome!
