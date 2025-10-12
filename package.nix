{
  perSystem = { pkgs, self', ... }:
    let 
      # What rustc version are we targeting
      version = "1.89.0.0";
      # Get our system string
      systemName = pkgs.stdenv.hostPlatform.system;
    in
    {
      packages.esp-rs = pkgs.callPackage ./esp-rs/package.nix { version = version; systemName = systemName; };
      packages.default = self'.packages.esp-rs;
    };
}
