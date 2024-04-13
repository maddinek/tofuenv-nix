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
    # Set environment variables
    #export MY_VAR1="value1"
    #export MY_VAR2="value2"

    # Set exports
    #export PATH="/path/to/custom/bin:$PATH"
    #export LD_LIBRARY_PATH="/path/to/custom/lib:$LD_LIBRARY_PATH"

    # Welcome message
    echo "Welcome to my development environment!"

    # Placeholder for tfenv functionality, directly using Terraform version managed by Nix
    echo "Using Terraform version: $(terraform --version | head -n 1)"
    echo "Using kubectl version: $(kubectl version --client | grep -E 'Client Version:' | awk '{print $3}')"
    echo "Using Helm version: $(helm version --short)"
    echo "Using AWS CLI version: $(aws --version)"
    echo "Using Ansible version: $(ansible --version | head -n 1)"
    echo "Using Python version: $(python --version)"
    echo "Using Node.js version: $(node --version)"

    # thefuck alias setup
    eval "$(thefuck --alias)"

    # For pyenv-like Python version management, consider using nix-shell shebangs or direnv with .envrc for project-specific environments
  '';
}
