{ stdenv, lib, makeWrapper, terraform, yajl, gnused }:

let
  inherit (lib) sourceByRegex;
in

stdenv.mkDerivation rec {
  name = "nixform";
  version = "0.1.0";
  buildInputs = [ makeWrapper terraform yajl gnused ];
  installPhase = ''
    mkdir -p $out/bin
    cp nixform $out/bin
    wrapProgram $out/bin/nixform --suffix PATH : ${terraform}/bin:${yajl}/bin:${gnused}/bin
  '';

  src = sourceByRegex ./. [
    "^nixform$"
  ];
}
