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
}