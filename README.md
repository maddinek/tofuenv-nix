
# Tofuenv Nix

This project provides a Nix derivation for the [Tofuenv](https://github.com/tofuutils/tofuenv) version manager, allowing you to easily install and use Tofuenv within a Nix environment. Tofuenv is a version manager for [OpenTofu](https://github.com/tofuutils/opentofu), a configuration language and processor, designed to facilitate the installation, management, and switching between different versions of OpenTofu.

## Prerequisites

- Nix package manager installed on your system

## Usage

1. **Clone this repository:**

   ```bash
   git clone https://github.com/maddinek/tofuenv-nix.git
   cd tofuenv-nix
   ```

2. **Build the Nix derivation:**

   ```bash
   nix-build shell.nix
   ```

3. **Enter the Nix shell environment:**

   ```bash
   nix-shell shell.nix
   ```

4. **Use Tofuenv commands inside the Nix shell:**

   ```bash
   tofuenv --version
   tofuenv install <version>
   tofuenv use <version>
   ```

   Replace `<version>` with the desired version of OpenTofu you want to install or use.

## Configuration

- `default.nix`: Contains the Nix derivation for Tofuenv.
- `shell.nix`: Defines the Nix shell environment with Tofuenv and other dependencies.
- `versions.nix`: Specifies the versions of Tofuenv and other packages used in the project.
- `packages.nix`: Lists the common packages included in the Nix shell environment.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

## References

- [Tofuenv](https://github.com/tofuutils/tofuenv) - Version manager for OpenTofu
- [OpenTofu](https://github.com/tofuutils/opentofu) - Configuration language and processor
