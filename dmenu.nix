{ lib, stdenv, fetchFromGitHub, pkgs }:

let
  pname = "dmenu";
  version = "5.2";
in stdenv.mkDerivation {
  inherit pname version;

  src = ./dmenu;

  buildInputs = with pkgs; with pkgs.xorg; [ libX11 libXinerama libXft zlib ];

  postPatch = ''
    sed -ri -e 's!\<(dmenu|dmenu_path|stest)\>!'"$out/bin"'/&!g' dmenu_run
    sed -ri -e 's!\<stest\>!'"$out/bin"'/&!g' dmenu_path
  '';

  preConfigure = ''
    sed -i "s@PREFIX = /usr/local@PREFIX = $out@g" config.mk
  '';

  makeFlags = [ "CC:=$(CC)" ];

  meta = {
    description =
      "A generic, highly customizable, and efficient menu for the X Window System";
    homepage = "https://tools.suckless.org/dmenu";
  };
}
