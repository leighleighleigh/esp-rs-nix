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
      "aarch64-linux" = "aarch64-unknown-linux-gnu";
      "aarch64-darwin" = "aarch64-apple-darwin";
    };

    # Version entries are entered below.
    "1.90.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-kxFqieItFj69lntVn32cy/GT4QQpQNwg1PA7lrvRB7Q=";
      "aarch64-unknown-linux-gnu" = "sha256-DneyDDKnhjACsTBySvxsw8QuXQO/r7uWMqCichYUCN8=";
      "aarch64-apple-darwin" = "sha256-YEP0vyY09hOPChb99baDJb39j7wijg/ReY7HDUE/9IA=";
    };
    "1.89.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-3mL6sG5Uu/PwvDXKZQs85WwSlQQn/MsVkQrxeZ4MhA4=";
      "aarch64-unknown-linux-gnu" = "sha256-DerxFgV7YY7koUpt7pWzP4vG88adojuYhAyoREya9fk=";
      "aarch64-apple-darwin" = "sha256-+gCjuvthNQMZ6/f7oy1C+h7pZFaPFr2yrGx6xUdfUMs=";
    };
    "1.88.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-rVASQiHRC+sJvi9rdVsO8IO0fAZKKGFqRzmSoR5faj0=";
      "aarch64-unknown-linux-gnu" = "sha256-E83ebNc1S6BcGzFqblVIfu8b49SwYUVDmmSMQWziTxQ=";
      "aarch64-apple-darwin" = "sha256-mcCjLZPot/CCmx5uZmw+AWsT/QWXun1q6kVMCnIF6oQ=";
    };
    "1.87.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-8OwFIa4UVzDtJXTsXXyUEGo3GFa1OFwNL8tJhKkcVrw=";
      "aarch64-unknown-linux-gnu" = "sha256-lWPqgxNuleOQrHmQnE3KQYuvDC1/uuoyLQShmcQe4cs=";
      "aarch64-apple-darwin" = "sha256-C8fWDuPlHf9UXkycFafCO8ghjNXkF+9abwvxBoG3mtM=";
    };
    "1.86.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-NEKcsHbgh0UwESLg5zR2o3ACIwMk4DiEfgzidctTJoY=";
      "aarch64-unknown-linux-gnu" = "sha256-oO6alCG63hBv1vLRPNpIto12iYR4NGO8Tad12S94d8s=";
      "aarch64-apple-darwin" = "sha256-UXVDgOnm8HO1wKQUC+cNfxS4wH2TCXS4+Zg5AFd9BdQ=";
    };
  };

  rust-src = {
    # Function to build the repo url
    urlBuilder = (version: "https://github.com/esp-rs/rust-build/releases/download/v${version}/rust-src-${version}.tar.xz");
    # Version entries are entered below.
    "1.90.0.0" = "sha256-WfICsnOG5Qm7eDIbB2kgCQ07ksMyRavWUvyNs2ASM0Q=";
    "1.89.0.0" = "sha256-4LgM2Erow7/ibniGEeZ8L6Aw2son6WJHay+O20+BifA=";
    "1.88.0.0" = "sha256-zWuLI2+q0rO9ANFZOEwLHbvaO+ZANI/MJpj/JBrhxiQ=";
    "1.87.0.0" = "sha256-Aaclpx+GP0ME/RMXoH8P7GZDOxT2tmVH2FR9wCqvvak=";
    "1.86.0.0" = "sha256-A++Q0Cd2x5EOb3NRT2iwzzsPR9g8cv/ZVQY+QkEJOAk=";
  };

  esp-gcc = {
    # Function to build the repo url
    urlBuilder = (arch: targetarch: ct-version: "https://github.com/espressif/crosstool-NG/releases/download/esp-${ct-version}/${targetarch}-esp-elf-${ct-version}-${arch}.tar.xz");

    # Mapping from NixOS system strings to the strings used by rust-build
    systemNameMap = {
      "x86_64-linux" = "x86_64-linux-gnu";
      "aarch64-linux" = "aarch64-linux-gnu";
      "aarch64-darwin" = "aarch64-apple-darwin";
    };

    # Version entries are entered below.
    "15.2.0_20250920" = {
      "xtensa" = {
        "x86_64-linux-gnu" = "sha256-TMjkfwsm9xwPYIowTrOgU+/Cst5uKV0xJH8sbxcTIlc=";
        "aarch64-apple-darwin" = "sha256-O0gXFHa127y5hzwRJeXcvs3ZtF2eK93YJcwut9P9gok=";
        "aarch64-linux-gnu" = "sha256-SL3wIxnkcYJw04A9J1GTmpLvlE1iby5HdtLYmFwRaps=";
      };
      "riscv32" = {
        "x86_64-linux-gnu" = "sha256-or85yVifw/j09F7I4pOdgut7Wti88LL1ftnyprX0A9E=";
        "aarch64-apple-darwin" = "sha256-ui6SL84mAXNOS9np+lQpJH4QqF9wTL86zyWwm7vv3NY=";
        "aarch64-linux-gnu" = "sha256-GKn2MGsSfY8ZNrq7KFM1nPo+ChK2dcNj3pyIMtaPDvY=";
      };
    };

    "15.1.0_20250607" = {
      "xtensa" = {
        "x86_64-linux-gnu" = "sha256-OLm7JQeeFdvTbga1s6D0aMFVGWjNhG023t/aHX+xxz0=";
        "aarch64-apple-darwin" = "sha256-OmAT9CfzBCa3o/DOEnrzNCRjHCNOjgPMzsueyT7qEo8=";
        "aarch64-linux-gnu" = "sha256-UmUr+RB12H7d7AMiykZ9/sTItRGA1AldftzqZ8iPDfI=";
      };
      "riscv32" = {
        "x86_64-linux-gnu" = "sha256-UEIlYiHqJDZ/S1bEwh47OcV5C8megc4F05n5Bh+vVM0=";
        "aarch64-apple-darwin" = "sha256-p986tt6XlLY8ielY6eMW6cytZgHUsq/0oRJ6ImNppaE=";
        "aarch64-linux-gnu" = "sha256-NYohDmMiy5DcbGvBI5ou8JgDCrQCY/LVylDs8zbi9yw=";
      };
    };
  };

  esp-gdb = {
    # Function to build the repo url
    urlBuilder = (arch: targetarch: version: "https://github.com/espressif/binutils-gdb/releases/download/esp-gdb-v${version}/${targetarch}-esp-elf-gdb-${version}-${arch}.tar.gz");

    # Mapping from NixOS system strings to the strings used by rust-build
    systemNameMap = {
      "x86_64-linux" = "x86_64-linux-gnu";
      "aarch64-linux" = "aarch64-linux-gnu";
    };

    # Version entries are entered below.
    "16.2_20250324" = {
      "xtensa" = {
        "x86_64-linux-gnu" = "sha256-gphR1KiiPKxlZ0cQKskiMQj3hkbiW7pwhHoF38cbBC0=";
        "aarch64-linux-gnu" = "sha256-FJTclD0rHIpABxBTwzU4mScC5l2hSnRu1PSyoN9BNAM=";
      };
      "riscv32" = {
        "x86_64-linux-gnu" = "sha256-uDro2vSq1HELT2n9mNhD+H5Ld1EBMfyGf3i+RGbPRjc=";
        "aarch64-linux-gnu" = "sha256-bl3bx8fXS4VGuL+u4bphM9vzOKaSPN1f6PDvh2gsfZA=";
      };
    };
  };
}