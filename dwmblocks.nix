{ lib, stdenv, fetchFromGitHub, pkgs }:

let
  pname = "dwmblocks";
  version = "0.1.0";
in stdenv.mkDerivation {
  inherit pname version;

  src = ./dwmblocks;

  nativeBuildInputs = [ pkgs.pkg-config ];
  buildInputs = with pkgs.xorg; [ libX11 libxcb xcbutil ];
  makeFlags = [ "PREFIX=$(out)" ];
}
