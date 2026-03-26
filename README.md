# flatrun

[English 🇬🇧](README.md)

[简体中文 🇨🇳](README_CHN.md)

[Español 🌎](README_SPN.md)

[日本語 💔](README_JPN.md)

A script to run a flatpak app without knowing the full App ID

This is a very simple script I created to alleviate my sadness and to pass the time after I had my heart broken. It wraps a flatpak application so users can run it simply by entering the application name, without needing to enter the full ID.


## Usage
```shell
Usage: flatrun [OPTIONS] APP_NAME [ -- SUB_COMMANDS]
Run a Flatpak application by matching its name or ID.

Options:
  -c    Case-sensitive matching (disables smart-filtering)
  -v    Show version information
  -h    Show this help message

Examples:
  flatrun steam              # Smart-matches to com.valvesoftware.Steam
  flatrun -c Steam           # Strict match; might show selection menu
  flatrun vlc -- --version   # Passes --version to VLC

```

## Installation

### Nix Flake:

You can run the shell directly via `nix run`:

```bash
nix run github:yisuidenghua/flatrun
```

Or add it to your system configuration:

```
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flatrun = {
      url = "github:yisuidenghua/flatrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
```

The package is available as `inputs.flatrun.packages.${pkgs.stdenv.hostPlatform.system}.default` which can be added to your `environment.systemPackages`, `users.users.<username>.packages`, `home.packages` if using home-manager, or a devshell.



### Other distros:

***Comming s∞n...***
