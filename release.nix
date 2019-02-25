{
  nixpkgs ?
    let
      hostPkgs = import <nixpkgs> {};
      pinnedVersion = hostPkgs.lib.importJSON ./nixpkgs.json;
    in hostPkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs-channels";
      inherit (pinnedVersion) rev sha256;
    },
  pkgs ? import nixpkgs { config = { allowUnfree = true; }; }
}:

pkgs.callPackage ./default.nix {}
