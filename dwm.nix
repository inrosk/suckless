{ lib, stdenv, fetchurl, pkgs }:

let
  pname = "dwm";
  version = "6.6";
in stdenv.mkDerivation rec {
  inherit pname version;

  src = ./dwm;

  buildInputs = with pkgs.xorg; [ libX11 libXinerama libXft ];

  prePatch = ''
    sed -i "s@/usr/local@$out@" config.mk
  '';

  makeFlags = [ "CC=${stdenv.cc.targetPrefix}cc" ];
}
