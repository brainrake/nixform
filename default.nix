let
  pkgs = import <nixpkgs> {};
in rec {
  nixform = pkgs.stdenv.mkDerivation rec {
    name = "nixform";
    version = "0.1.0";
    buildInputs = [ pkgs.terraform pkgs.yajl ];
    installPhase = ''mkdir -p $out/bin && cp nixform $out/bin'';
    src = ./.;
  };
}
