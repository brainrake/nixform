{
  nixpkgs ?
    # Pinned for reproducibility, release-18.03.
    # to update use
    # nix-prefetch-url --unpack https://github.com/$owner/$repo/archive/$rev.tar.gz 2>&1 | tail -n 1
    (import <nixpkgs> {}).pkgs.fetchFromGitHub {
      owner  = "NixOS";
      repo   = "nixpkgs";
      rev    = "3af00107ea2e7669d3edac0897aa28bd5570b3c1";
      sha256 = "06s3y149d5y96axprpxv7ap6l39v9jqvy81fq6vzsk3qk20cr525";
    }
}:
let
  config   = { allowUnfree = true; };

  pkgs = import nixpkgs { inherit config; };
in
  pkgs.callPackage ./default.nix {}
