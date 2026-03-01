#!/usr/bin/env bash
# Takes in a list of crosstool-NG version tags,
# forms URLs for each of them,
# then uses nix-prefetch-url and nix-hash to get the version hash.
# the value 'N' is used to adjust parallelism

version_list="crosstool-NG-tags.txt"

print_headers()
{
    echo "version,chip,arch,url,hash"
}

make_url()
{
    # tag is of the form 'esp-$version'
    # but we want just the '$version' part.
    v="${1#esp-}"
    for chip in "xtensa" "riscv32";
    do
      for t in "x86_64-linux-gnu" "aarch64-apple-darwin" "aarch64-linux-gnu";
      do
          url="https://github.com/espressif/crosstool-NG/releases/download/esp-${v}/${chip}-esp-elf-${v}-${t}.tar.xz"

          # hash the file then convert to SRI format
          h=$(nix-prefetch-url --unpack --type sha256 "${url}" 2>/dev/null)
          srihash=$(nix-hash --type sha256 --to-sri "${h}" 2>/dev/null)
            
          if [[ "$?" -eq 0 ]];
          then
              echo "${v},${chip},${t},${url},${srihash}"
          else
              echo "${v},${chip},${t},${url},XXXXXXXXXXXXXXXX"
          fi
      done
    done
}

export -f make_url
print_headers
cat "${version_list}" | xargs -P1 -I{} bash -c 'make_url "{}"'
