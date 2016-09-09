let
  pkgs = import <nixpkgs> {};
in rec {
  nixform = pkgs.stdenv.mkDerivation rec {
    name = "nixform";
    version = "0.1.0";
    buildInputs = [ pkgs.makeWrapper pkgs.terraform pkgs.yajl ];
    installPhase = ''
      mkdir -p $out/bin
      cp nixform $out/bin
      wrapProgram $out/bin/nixform --suffix PATH : ${pkgs.terraform}/bin:${pkgs.yajl}/bin
    '';
    src = ./.;
  };
}
