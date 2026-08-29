# !!!THIS FILE IS ONLY HERE TO PROVIDE BACKWARDS-COMPATIBILITY
# WITH 'PRE-FLAKE' USERS OF THIS REPO!!!
{ pkgs, lib, ... }:
let
  systemName = pkgs.stdenv.hostPlatform.system;
in
lib.warn
  "The file 'esp-rs/default.nix' is deprecated, please use the top-level 'package.nix' file instead."
  pkgs.callPackage
  ../package.nix
  { }
