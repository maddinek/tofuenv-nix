# shell.nix
{ pkgs ? import <nixpkgs> {} }:

let
  versions = import ./versions.nix;
  commonPackages = import ./packages.nix { inherit pkgs; };
  tofuenv = pkgs.callPackage ./default.nix {};
in
pkgs.mkShell {
  buildInputs = commonPackages ++ [ tofuenv ];

  shellHook = ''
    # Welcome message
    echo "Welcome to my development environment!"

    # Placeholder for tfenv functionality, directly using Terraform version managed by Nix
    echo "Using kubectl version: $(kubectl version --client | grep -E 'Client Version:' | awk '{print $3}')"
    echo "Using Helm version: $(helm version --short)"
    echo "Using AWS CLI version: $(aws --version)"
    echo "Using Ansible version: $(ansible --version | head -n 1)"
  '';
}
