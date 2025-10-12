#!/usr/bin/env bash

for v in "15.2.0_20250920" "15.1.0_20250607";
do
    echo "\"${v}\" = {"

      for chip in "xtensa" "riscv32";
      do
          echo "  \"${chip}\" = {"

          for t in "x86_64-linux-gnu" "aarch64-apple-darwin" "aarch64-linux-gnu";
          do
              url="https://github.com/espressif/crosstool-NG/releases/download/esp-${v}/${chip}-esp-elf-${v}-${t}.tar.xz"
              # hash the file then convert to SRI format
              h=$(nix-prefetch-url --unpack --type sha256 "${url}" 2>/dev/null)
              srihash=$(nix-hash --type sha256 --to-sri "${h}")
              echo "    \"${t}\" = \"${srihash}\";"
          done

          echo "  };"
      done

    echo "};"
done
