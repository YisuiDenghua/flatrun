{
  description = "Flatrun: Run Flatpak apps by name";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.callPackage ./nix/default.nix { version = "0.1.2"; };

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/flatrun";
        };
      }
    );
}
