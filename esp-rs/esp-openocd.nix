{
  stdenv,
  lib,
  fetchurl,
  pkg-config,
  gnumake,
  gcc,
  coreutils,
  hidapi,
  libusb1,
  findutils,
  binutils,
  autoPatchelfHook,
  tcl,
  jimtcl,
  automake,
  autoconf,
  texinfo,
  libtool,
  which,
  libz,
}:
stdenv.mkDerivation rec {
  pname = "openocd";
  version = "0.12.0-esp32-20250707";

  src = fetchurl {
       url = "https://github.com/espressif/openocd-esp32/archive/refs/tags/v${version}.tar.gz";
       sha256 = "sha256-8gn44PSAa3g6Jfkv6nR9urGrkQbTGKz4KD7yI22gYAk=";
  };
  
  nativeBuildInputs = [
    autoPatchelfHook
    autoconf
    automake
    binutils.bintools
    coreutils
    findutils
    gcc
    gnumake
    libtool
    pkg-config
    tcl
    which
  ];

  buildInputs = [
    jimtcl
    libusb1
    libz
    texinfo
  ];

  configurePhase = ''
  patchShebangs ./bootstrap
  ./bootstrap
  patchShebangs ./configure
  ./configure --prefix=$out
  '';

  configureFlags = [
    "--disable-werror"
  ];
}

