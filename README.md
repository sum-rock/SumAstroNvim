# Sum Rock's AstroNvim Implementation

This is an implementation of the [AstroNvim](https://astronvim.com/)
configuration/plugin distribution for Neovim using Nix flakes. The flake contains both a
NixOS and NixDarwin module which allows for easy adaptation and installation. The flake
is not intended to be highly configurable, it was instead designed to allow me to easily
port my highly configured Neovim setup to other machines.

## Installation

A very minimal installation in a typical nix flake would look as follows:

`flake.nix`

```nix
{
  description = "My NixOS configuration";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-23.11";
    };
    sum-astro-nvim = {
      url = "github:sum-rock/SumAstroNvim/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, sum-astro-nvim }:
  {
    nixosConfigurations = {
      "my-hostname" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          sum-astro-nvim.nixosModules.astroNvim
        ];
      };
    };
  };
}
```

`configuration.nix`

```nix
{ config, pkgs, ...}:
{
  sumAstroNvim = {
    username = "sumrock";
    nerdfont = "FiraCode";
    nodePackage = pkgs.nodejs_20;
    pythonPackage = pkgs.python311Full;
  };

  # Everything else required to configure your machine...
}
```
