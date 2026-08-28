{

  # Hand-written attribute tree, containing
  # sha256 hashes for all systems and version numbers,
  # for rust-build and crosstool-NG artifacts.
  rust-build = {
    # Function to build the repo url
    urlBuilder = (
      arch: version:
      "https://github.com/esp-rs/rust-build/releases/download/v${version}/rust-${version}-${arch}.tar.xz"
    );

    # Mapping from NixOS system strings to the strings used by rust-build
    systemNameMap = {
      "x86_64-linux" = "x86_64-unknown-linux-gnu";
      "aarch64-linux" = "aarch64-unknown-linux-gnu";
      "aarch64-darwin" = "aarch64-apple-darwin";
    };

    # Version entries are entered below.
    "1.98.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-B+agdGDROpCs0Flj8FFkfAUtVrGDgfi9wDGCsTnVJX0=";
      "aarch64-unknown-linux-gnu" = "sha256-FLlcvn8KK4B1fdkyigw/ehWvY7N63qEtzOzjzNMCT0w=";
      "aarch64-apple-darwin" = ""; # Not available
    };
    "1.97.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-CnxysCl+Hcllge0olHSBOstgbhqDsCRAhg+mDUAnEs0=";
      "aarch64-unknown-linux-gnu" = "sha256-d3xoQ781VFrJv7rxv36itHHrMf2VqPunUG9+HBZ1sNg=";
      "aarch64-apple-darwin" = "sha256-oH8XnhisbsK3xTshckZk3m7YkzeB/Ux5vP4u1O+v8Gg=";
    };
    "1.96.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-4dJQAuyxC5SQDwnDqeM0SmRTQBMw3amqbMEiJwSDpE8=";
      "aarch64-unknown-linux-gnu" = "sha256-E7yQrKolaqNFcH/Q0+/VH5J6FzF8ewZSIcPijBi8QLc=";
      "aarch64-apple-darwin" = "sha256-8pZxvVgv7d0yIx37bdewbNmviwCoIwgVxcuPBeYack8=";
    };
    "1.95.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-3wpKYEA9i9+/6OkzuBjFD7MSufN8ZCgBmUNdB2LeprI=";
      "aarch64-unknown-linux-gnu" = "sha256-VNfHp3+0dhhlxEcjA/zV+J3AnioLNxWsm9rOJg+POFA=";
      "aarch64-apple-darwin" = "sha256-DDRLSBG/8WqyD0lZkSFsln1Xj11cKf2mItUZzQYSh6Q=";
    };
    "1.94.0.2" = {
      "x86_64-unknown-linux-gnu" = "sha256-RmpTNJP2LyKiF/JXmGiUtGL+DfnQEI2VhpcHztQJZto=";
      "aarch64-unknown-linux-gnu" = "sha256-UeprucOWqO/XUm4zcZsVaT2BGxgqXxbJVheUBkBAYfE=";
      "aarch64-apple-darwin" = "sha256-cSiw5EWEhA7N2aYPyuDme1TyEMRcs/Yrh1+NFuJmW3U=";
    };
    "1.94.0.1" = {
      "x86_64-unknown-linux-gnu" = "sha256-J3uTefE0H1rF9vbtn/gseGe1gehPe9d33jRPAtO3+qc=";
      "aarch64-unknown-linux-gnu" = ""; # Not available
      "aarch64-apple-darwin" = "sha256-IcsWCRPCjXFNxJm+dNafLMW7NHuvz7QDfSf1OFNW/CQ=";
    };
    "1.94.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-BtbcS85H9f4SXtsQVkOOS7qJeNVHxrz4mVtky6cV/uw=";
      "aarch64-unknown-linux-gnu" = "sha256-c1EJR6QNslYtoQbfK7NHxAFPgAZt4yHyjo4ktstXmHw=";
      "aarch64-apple-darwin" = "sha256-vvhTaPsuH0nsms8kYCsJS8hTU0vMaOxi0lucLS8slIM=";
    };
    "1.93.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-837shgsDonrmUqZsIhUoR+93IR8tUat67PiHfShilJc=";
      "aarch64-unknown-linux-gnu" = "sha256-QdQNRBW3/0GRYZelGPsRzW/K3gP8chlV57b2lqysz4Q=";
      "aarch64-apple-darwin" = "sha256-r28XuKyh5pAXeW7gblSzGDcIXc2EPHj1C9+UwKbL6UY=";
    };
    "1.92.0.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-6enJJdfzU4OmXMdyu8jtrchmO0+8tZFmfn9P3GYsnIY=";
      "aarch64-unknown-linux-gnu" = "sha256-srgvDco4SoxN3uRyHE2w0Oq9PHQQXD7a59ycIdmP8KE=";
      "aarch64-apple-darwin" = "sha256-PDo+amtmQW4WgwbDVlcAhDoqkUYDV+kUPoQmvHDYGS8=";
    };
    "1.91.1.0" = {
      "x86_64-unknown-linux-gnu" = "sha256-+XSHYwZRqzQmy2XEQVljvTcgwKkx8Y3ZKHQWgbRJ1pI=";
      "aarch64-unknown-linux-gnu" = "sha256-XPHmkPk/qaR3B1inR7d9zrACJDlfik4CbMj9BYsrN+g=";
      "aarch64-apple-darwin" = "sha256-iRTnPWFARS70lEJi6szcnVlTFCkzYPhdnpkB50I+Wu8=";
    };
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
    urlBuilder = (
      version:
      "https://github.com/esp-rs/rust-build/releases/download/v${version}/rust-src-${version}.tar.xz"
    );
    # Version entries are entered below.
    "1.98.0.0" = "sha256-rGudSCkk6dvqMi1JxvJaQ90Pg2vpk+SwJQFECDT1wk0=";
    "1.97.0.0" = "sha256-0Q/hfXD0R1pVzTgS0N8X2D3ZvPYX4y4k/EmxPy2474k=";
    "1.96.0.0" = "sha256-Ry7y+N37g+S9tgbJVhUBcd+W7NQgrksylHL17f8759E=";
    "1.95.0.0" = "sha256-mUpucCIRJxgFWiW5HlT95ZKvA+u4+T5CvEfgoQZoNOA=";
    "1.94.0.2" = "sha256-l1pVzP1kaZne7U8naNGB28BnnIoqDEpklBrG5bIz+v8=";
    "1.94.0.1" = "sha256-j5hByMifhyQQavgitvpXlfeobqa/G0zbMopxvMaKeKc=";
    "1.94.0.0" = "sha256-LpD+emGLgfoALvsj9GDesJm7hstb7AGdqHuAkrqtGgo=";
    "1.93.0.0" = "sha256-upKiKRDvubE8obME4OVewTr6PjS/p0QOqjpQfEWBfE0=";
    "1.92.0.0" = "sha256-nMTDpzKnjanFe8ttqPBYbIOcC3/f8HD7FgyzT4yO4M4=";
    "1.91.1.0" = "sha256-3p4K15Bnin7gptpB7ub1TaYvRdWhy4AECtrWxy3wS74=";
    "1.90.0.0" = "sha256-WfICsnOG5Qm7eDIbB2kgCQ07ksMyRavWUvyNs2ASM0Q=";
    "1.89.0.0" = "sha256-4LgM2Erow7/ibniGEeZ8L6Aw2son6WJHay+O20+BifA=";
    "1.88.0.0" = "sha256-zWuLI2+q0rO9ANFZOEwLHbvaO+ZANI/MJpj/JBrhxiQ=";
    "1.87.0.0" = "sha256-Aaclpx+GP0ME/RMXoH8P7GZDOxT2tmVH2FR9wCqvvak=";
    "1.86.0.0" = "sha256-A++Q0Cd2x5EOb3NRT2iwzzsPR9g8cv/ZVQY+QkEJOAk=";
  };

  esp-gcc = {
    # Function to build the repo url
    urlBuilder = (
      arch: targetarch: ct-version:
      "https://github.com/espressif/crosstool-NG/releases/download/esp-${ct-version}/${targetarch}-esp-elf-${ct-version}-${arch}.tar.xz"
    );

    # Mapping from NixOS system strings to the strings used by rust-build
    systemNameMap = {
      "x86_64-linux" = "x86_64-linux-gnu";
      "aarch64-linux" = "aarch64-linux-gnu";
      "aarch64-darwin" = "aarch64-apple-darwin";
    };

    # Version entries are entered below.
    "16.1.0_20260609" = {
      "xtensa" = {
        "x86_64-linux-gnu" = "sha256-D02nz89injwvi+CD8tE8j/xkp1YrS28XvAmqCd3Dm+A=";
        "aarch64-apple-darwin" = "sha256-bft1RXttXlXsY4JvTMjPdx3/Y6RQhs4xF7j1K5NRxxU=";
        "aarch64-linux-gnu" = "sha256-IDtyN17fp76TubeBKkD8bDm0+k8LOz/lRCLFtbkHax8=";
      };
      "riscv32" = {
        "x86_64-linux-gnu" = "sha256-XmWOvWlgKYgZHpquEx3qUVjkwfYrpGZF386GfVDWdAA=";
        "aarch64-apple-darwin" = "sha256-eomHacTGWiGZ21Zq93wS6AIhAZagW7PfSs4S6a28vho=";
        "aarch64-linux-gnu" = "sha256-eI3dWyuZGRgUKjEuQgLj/l4Rf03EMqYiXe5ipQFH1Bs=";
      };
    };

    "15.2.0_20251204" = {
      "xtensa" = {
        "x86_64-linux-gnu" = "sha256-f2zKqpgdYqKRwvgFsPGrG4jiborzjam5aOPGqso0Lqg=";
        "aarch64-apple-darwin" = "sha256-fBFjvLVhrJZY6pnQwZ01EDNtfbVZEiSYV0ZOmYmA0ZM=";
        "aarch64-linux-gnu" = "sha256-Mpym5XKjjDdbJA78y58ilfJG5Kkn7x9C3FhP1pXbr5k=";
      };
      "riscv32" = {
        "x86_64-linux-gnu" = "sha256-Jy3DScJ9UiEJcPLVqfV5fVgg9uAmk9OZKZDEq1aPSFk=";
        "aarch64-apple-darwin" = "sha256-kpOheh0gzxhKb6kOt5XNnrsJjbjFd06QgBOHNJa90GI=";
        "aarch64-linux-gnu" = "sha256-2W3qQ1kYzHqfFC7lAbiuAzRPAB22TbLRgtR8VRCMTD0=";
      };
    };

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
    urlBuilder = (
      arch: targetarch: version:
      "https://github.com/espressif/binutils-gdb/releases/download/esp-gdb-v${version}/${targetarch}-esp-elf-gdb-${version}-${arch}.tar.gz"
    );

    # Mapping from NixOS system strings to the strings used by rust-build.
    # NOTE: Because binutils changes this mapping between versions, I've had to make this systemNameMap attribute depend on versions too.
    systemNameMap = {
      "17.1_20260402" = {
        "x86_64-linux" = "x86_64-linux-gnu";
        "aarch64-linux" = "aarch64-linux-gnu";
        "aarch64-darwin" = "aarch64-apple-darwin24.5";
      };
      "16.3_20250913" = {
        "x86_64-linux" = "x86_64-linux-gnu";
        "aarch64-linux" = "aarch64-linux-gnu";
        "aarch64-darwin" = "aarch64-apple-darwin24.5";
      };
      "16.2_20250324" = {
        "x86_64-linux" = "x86_64-linux-gnu";
        "aarch64-linux" = "aarch64-linux-gnu";
        "aarch64-darwin" = "aarch64-apple-darwin21.1";
      };
    };

    # Version entries are entered below.
    "17.1_20260402" = {
      "xtensa" = {
        "x86_64-linux-gnu" = "sha256-wnlCFiWYEsewjhx07ZXTzVn8/e67zACTafNAwlzcG/I=";
        "aarch64-linux-gnu" = "sha256-VqJhq1MGyPaQ1PlgC1Pe5dbOCdMIMgAdMgiLRoRL18c=";
        "aarch64-apple-darwin24.5" = "sha256-zMQoaBgjm/vJCbuo4C63nWyTK+N/BDZOjSeFtNZ6eqI=";
      };
      "riscv32" = {
        "x86_64-linux-gnu" = "sha256-Ldh/Qrxw5fbxhYDYZXqLuU+Jn40cR5VwuTxwPCpTYPs=";
        "aarch64-linux-gnu" = "sha256-lj7SXqk3LstWaNFk0agBLvnG1Yq/5o3Pzgi1TA8r0LA=";
        "aarch64-apple-darwin24.5" = "sha256-+W4fBwCTXlKbOSyl3kdJEpX4bgR0dMCEkfZLD1MLL3Y=";
      };
    };

    "16.3_20250913" = {
      "xtensa" = {
        "x86_64-linux-gnu" = "sha256-LLbllfc+QvPyuv1mqNwgKDVTCMdDI4fDm+yt7dj2q1A=";
        "aarch64-linux-gnu" = "sha256-OEQmdd2urX7f2vDMlLFKJ3WQjT3TJCcOusarYneSsYE=";
        "aarch64-apple-darwin24.5" = "sha256-0Gx6SquQyPQobJNxSlaUHWQZq+vBWJx3ahSACpFu/50=";
      };
      "riscv32" = {
        "x86_64-linux-gnu" = "sha256-XN0ED+rlOjrWLGpC4gBdPcGkPF5bQgiG1IyHjtmYKoI=";
        "aarch64-linux-gnu" = "sha256-O7uGkX89KUv2YEB7UA2rt9FmU8L4J7bvKcNxorFVIPg=";
        "aarch64-apple-darwin24.5" = "sha256-T+2utYRNOH112pJtBMBeW32so6jsGNG1eTJ4TwarcIk=";
      };
    };

    "16.2_20250324" = {
      "xtensa" = {
        "x86_64-linux-gnu" = "sha256-gphR1KiiPKxlZ0cQKskiMQj3hkbiW7pwhHoF38cbBC0=";
        "aarch64-linux-gnu" = "sha256-FJTclD0rHIpABxBTwzU4mScC5l2hSnRu1PSyoN9BNAM=";
        "aarch64-apple-darwin21.1" = "sha256-blN5BXz2ZQaduzq66DbZroucDEOu64kejo/bSWHp8+Q=";
      };
      "riscv32" = {
        "x86_64-linux-gnu" = "sha256-uDro2vSq1HELT2n9mNhD+H5Ld1EBMfyGf3i+RGbPRjc=";
        "aarch64-linux-gnu" = "sha256-bl3bx8fXS4VGuL+u4bphM9vzOKaSPN1f6PDvh2gsfZA=";
        "aarch64-apple-darwin21.1" = "sha256-yiV8jQS1L0yZRKzKJZbkl2F2FLrwT5huKwTRRAevgQ4=";
      };
    };
  };
}
