let
  pkgs = import <nixpkgs> {};
in rec {
  nixformEnv = pkgs.stdenv.mkDerivation rec {
    name = "nixform-env";
    version = "0.1.0";
    buildInputs = [ pkgs.terraform pkgs.yajl ];
  };
}
