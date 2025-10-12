#!/usr/bin/env bash

# note the additiona '24.5' at the end of the darwin one. idk why they have to change this.
darwin_postfix="24.5";

for v in "16.3_20250913" ;
do
    echo "\"${v}\" = {"

      for chip in "xtensa" "riscv32";
      do
          echo "  \"${chip}\" = {"
          
          for t in "x86_64-linux-gnu" "aarch64-linux-gnu" "aarch64-apple-darwin$darwin_postfix";
          do
              url="https://github.com/espressif/binutils-gdb/releases/download/esp-gdb-v${v}/${chip}-esp-elf-gdb-${v}-${t}.tar.gz";
              # hash the file then convert to SRI format
              h=$(nix-prefetch-url --unpack --type sha256 "${url}" 2>/dev/null)
              srihash=$(nix-hash --type sha256 --to-sri "${h}")
              echo "    \"${t}\" = \"${srihash}\";"
          done

          echo "  };"
      done

    echo "};"
done
