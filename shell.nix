{ pkgs ? import <nixpkgs> {} }:

let
  tofuenv = pkgs.callPackage ./default.nix {};
in
pkgs.mkShell {
  buildInputs = [ pkgs.gnugrep tofuenv ];

  shellHook = ''
    echo "Welcome to my development environment!"
    echo "Using tofuenv version: $(tofuenv --version)"
  '';
}
