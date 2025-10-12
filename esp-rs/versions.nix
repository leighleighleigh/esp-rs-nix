{

  # Hand-written attribute tree, containing
  # sha256 hashes for all systems and version numbers,
  # for rust-build and crosstool-NG artifacts.
  rust-build = {
    # Function to build the repo url
    urlBuilder = (arch: version: "https://github.com/esp-rs/rust-build/releases/download/v${version}/rust-${version}-${arch}.tar.xz");

    # Mapping from NixOS system strings to the strings used by rust-build
    systemNameMap = {
      "x86_64-linux" = "x86_64-unknown-linux-gnu";
    };

    # Version entries are entered below.
    "1.89.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-3mL6sG5Uu/PwvDXKZQs85WwSlQQn/MsVkQrxeZ4MhA4=";
    };
  };

  rust-src = {
    # Function to build the repo url
    urlBuilder = (version: "https://github.com/esp-rs/rust-build/releases/download/v${version}/rust-src-${version}.tar.xz");
    # Version entries are entered below.
    "1.89.0.0" = "sha256-4LgM2Erow7/ibniGEeZ8L6Aw2son6WJHay+O20+BifA=";
  };

  esp-gcc = {
    # Function to build the repo url
    urlBuilder = (arch: targetarch: ct-version: "https://github.com/espressif/crosstool-NG/releases/download/esp-${ct-version}/${targetarch}-esp-elf-${ct-version}-${arch}.tar.xz");

    # Mapping from NixOS system strings to the strings used by rust-build
    systemNameMap = {
      "x86_64-linux" = "x86_64-linux-gnu";
    };

    # Version entries are entered below.
    "15.1.0_20250607" = {
      "xtensa" = {
        "x86_64-linux-gnu" = "sha256-OLm7JQeeFdvTbga1s6D0aMFVGWjNhG023t/aHX+xxz0=";
      };
      "riscv32" = {
        "x86_64-linux-gnu" = "sha256-UEIlYiHqJDZ/S1bEwh47OcV5C8megc4F05n5Bh+vVM0=";
      };
    };
  };

  esp-gdb = {
    # Function to build the repo url
    urlBuilder = (arch: targetarch: version: "https://github.com/espressif/binutils-gdb/releases/download/esp-gdb-v${version}/${targetarch}-esp-elf-gdb-${version}-${arch}.tar.gz");

    # Mapping from NixOS system strings to the strings used by rust-build
    systemNameMap = {
      "x86_64-linux" = "x86_64-linux-gnu";
    };

    # Version entries are entered below.
    "16.2_20250324" = {
      "xtensa" = {
        "x86_64-linux-gnu" = "sha256-gphR1KiiPKxlZ0cQKskiMQj3hkbiW7pwhHoF38cbBC0=";
      };
      "riscv32" = {
        "x86_64-linux-gnu" = "sha256-uDro2vSq1HELT2n9mNhD+H5Ld1EBMfyGf3i+RGbPRjc=";
      };
    };
  };
}