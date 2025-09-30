{
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; };

  outputs = { nixpkgs, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
      pkgs' = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in {
      packages = forAllSystems (system:
        let pkgs = pkgs'.${system};
        in {
          dwm = pkgs.callPackage ./dwm.nix { };
          dwmblocks = pkgs.callPackage ./dwmblocks.nix { };
          dmenu = pkgs.callPackage ./dmenu.nix { };
          st = pkgs.callPackage ./st.nix { };
        });
      devShells = forAllSystems (system:
        let pkgs = pkgs'.${system};
        in with pkgs; {
          default = mkShell {
            packages = [ clang-tools ];

            buildInputs = with xorg; [ libX11 libXinerama libXft ];

            # shellHook = ''
            #   # .
            # '';
          };
        });
    };
}
