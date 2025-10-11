{
  perSystem = { pkgs, self', ... }:
    let 
      esp-rs-src = pkgs.lib.sources.cleanSource ./.;
    in
    {
      packages.esp-rs = pkgs.callPackage "${esp-rs-src}/esp-rs/default.nix" { };
      packages.default = self'.packages.esp-rs;
    };
}
